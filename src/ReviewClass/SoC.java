package ReviewClass;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class SoC {
	public static String getClassName(String coursecode, String term) {
		String[] codearr = coursecode.split("-");
		String dept = codearr[0];
		String result = "";
		
		System.out.println("dept: " + dept + " - #: " + codearr[1]);
		
		JsonObject body = getDepartment(dept, term);
		
		System.out.println("body: " + body);
		
		if (body != null) {
			JsonArray listarr = body.get("OfferedCourses").getAsJsonObject().get("course").getAsJsonArray();
			for (JsonElement ele : listarr) {
				JsonObject obj = ele.getAsJsonObject();
				String code = obj.get("CourseData").getAsJsonObject().get("prefix").getAsString() + "-"
						+ obj.get("CourseData").getAsJsonObject().get("number").getAsString();
				if (coursecode.equals(code)) {
					JsonElement temp = obj.get("CourseData").getAsJsonObject().get("SectionData");
					if(temp.isJsonArray()) {
						result = temp.getAsJsonArray().get(0).getAsJsonObject().get("title").toString();
					}
					else {
						result = temp.getAsJsonObject().get("title").getAsString();
					}
				}
			}
		}
		System.out.println("In SOC getClassName: " + result);
		return result;
	}

	private static JsonObject GetResponseBody(BufferedReader in) {
		if (in != null) {
			String line;
			StringBuffer response = new StringBuffer();
			try {
				while ((line = in.readLine()) != null) {
					response.append(line);
				}
				in.close();
				JsonObject responseObj = null;

				String responseStr = response.toString();
				if (responseStr != null && !responseStr.trim().equals("")) {
					JsonParser parser = new JsonParser();
					responseObj = parser.parse(responseStr).getAsJsonObject();
					return responseObj;
				}
			} catch (IOException e) {
				System.out.println("IOException 2");
			}
		}
		return null;
	}

	private static JsonObject getDepartment(String dept, String term) {
		// Make call to SoC API
		String url = "https://web-app.usc.edu/web/soc/api/classes/" + dept + "/" + term;
		try {
			URL url1 = new URL(url);
			HttpURLConnection con = (HttpURLConnection) url1.openConnection();
			con.setRequestMethod("GET");
			BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
			if (con.getResponseCode() >= 200 && con.getResponseCode() < 300) {
				return GetResponseBody(in);
			}
		} catch (MalformedURLException e) {
			System.out.println(url);
			System.out.println("Malformed URL");
		} catch (IOException e) {
			System.out.println(url);
			System.out.println("IOException");
		}
		return null;
	}
	
	private static ArrayList<String> getDepartments(String term){
		ArrayList<String> results = new ArrayList<>();
		String url = "https://web-app.usc.edu/web/soc/api/depts/" + term;
		try {
			URL url1 = new URL(url);
			HttpURLConnection con = (HttpURLConnection) url1.openConnection();
			con.setRequestMethod("GET");
			BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
			if (con.getResponseCode() >= 200 && con.getResponseCode() < 300) {
				JsonObject body =  GetResponseBody(in);
				if (body != null) {
						JsonArray listarr = body.get("department").getAsJsonArray();
						for (JsonElement ele : listarr) {
							JsonObject obj = ele.getAsJsonObject();
							JsonElement dept = obj.get("department");
							if(dept!=null && dept.isJsonArray()) {
								JsonArray deptarr = obj.get("department").getAsJsonArray();
								for (JsonElement ele2 : deptarr) {
									JsonObject obj2 = ele2.getAsJsonObject();
									results.add(obj2.get("code").getAsString());
								}
							}
							else {
								results.add(obj.get("code").getAsString());
							}
						}
				}
			}
		} catch (MalformedURLException e) {
			System.out.println("Malformed URL");
		} catch (IOException e) {
			System.out.println("IOException");
		}
		return results;
	}
	
	public static void nameSearch(String query, String term, ArrayList<SCholasticClass> classes) {
		ArrayList<String> departments  = getDepartments(term);
		for(String dept: departments) {
			JsonObject body = getDepartment(dept, term);
			if(body == null)
				continue;
			JsonObject offered = body.get("OfferedCourses").getAsJsonObject();
			JsonElement listele = offered.get("course");
			if(listele.isJsonArray()) {
				JsonArray listarr = listele.getAsJsonArray();
				for (JsonElement ele : listarr) {
					JsonObject obj = ele.getAsJsonObject();
					String name = obj.get("CourseData").getAsJsonObject().get("title").getAsString();
					String code = obj.get("CourseData").getAsJsonObject().get("prefix").getAsString() + "-"
							+ obj.get("CourseData").getAsJsonObject().get("number").getAsString();
					if (name.toLowerCase().contains(query.toLowerCase())) {
						JsonElement temp = obj.get("CourseData").getAsJsonObject().get("SectionData");
						if(temp.isJsonArray()) {
							JsonArray sections = temp.getAsJsonArray();
							for(JsonElement section : sections) {
								JsonObject obj2 = section.getAsJsonObject();
								JsonElement ele3 = obj2.get("instructor");
								if(ele3==null)
									continue;
								if(ele3.isJsonArray()) {
									JsonArray teachers = ele3.getAsJsonArray();
									for(JsonElement ele4 : teachers) {
										JsonObject obj3 = ele4.getAsJsonObject();
										String teacher = obj3.get("last_name").getAsString() + "," + obj3.get("first_name").getAsString();
										if(!contains(code,teacher,classes)) {
											SCholasticClass c = new SCholasticClass(name, code, teacher);
											classes.add(c);
										}
									}
								}
								else {
									String teacher = obj2.get("instructor").getAsJsonObject().get("last_name").getAsString() + "," + obj2.get("instructor").getAsJsonObject().get("first_name").getAsString();
									if(!contains(code,teacher,classes)) {
										SCholasticClass c = new SCholasticClass(name, code, teacher);
										classes.add(c);
									}
								}
							}
						}
						else {
							JsonObject obj2 = temp.getAsJsonObject();
							JsonElement ele3 = obj2.get("instructor");
							if(ele3==null)
								continue;
							if(ele3.isJsonArray()) {
								JsonArray teachers = ele3.getAsJsonArray();
								for(JsonElement ele4 : teachers) {
									JsonObject obj3 = ele4.getAsJsonObject();
									String teacher = obj3.get("last_name").getAsString() + "," + obj3.get("first_name").getAsString();
									if(!contains(code,teacher,classes)) {
										SCholasticClass c = new SCholasticClass(name, code, teacher);
										classes.add(c);
									}
								}
							}
							else {
								String teacher = obj2.get("instructor").getAsJsonObject().get("last_name").getAsString() + "," + obj2.get("instructor").getAsJsonObject().get("first_name").getAsString();
								if(!contains(code,teacher,classes)) {
									SCholasticClass c = new SCholasticClass(name, code, teacher);
									classes.add(c);
								}
							}
						}
					}
				}
			}
		}
	}
	
	public static void coursecodeSearch(String query, String term, ArrayList<SCholasticClass> classes) {
		ArrayList<String> departments  = getDepartments(term);
		for(String dept: departments) {
			JsonObject body = getDepartment(dept, term);
			if(body == null)
				continue;
			JsonObject offered = body.get("OfferedCourses").getAsJsonObject();
			JsonElement listele = offered.get("course");
			if(listele.isJsonArray()) {
				JsonArray listarr = listele.getAsJsonArray();
				for (JsonElement ele : listarr) {
					JsonObject obj = ele.getAsJsonObject();
					String name = obj.get("CourseData").getAsJsonObject().get("title").getAsString();
					String code = obj.get("CourseData").getAsJsonObject().get("prefix").getAsString() + "-"
							+ obj.get("CourseData").getAsJsonObject().get("number").getAsString();
					if (code.toLowerCase().equals(query.toLowerCase())) {
						JsonElement temp = obj.get("CourseData").getAsJsonObject().get("SectionData");
						if(temp.isJsonArray()) {
							JsonArray sections = temp.getAsJsonArray();
							for(JsonElement section : sections) {
								JsonObject obj2 = section.getAsJsonObject();
								JsonElement ele3 = obj2.get("instructor");
								if(ele3==null)
									continue;
								if(ele3.isJsonArray()) {
									JsonArray teachers = ele3.getAsJsonArray();
									for(JsonElement ele4 : teachers) {
										JsonObject obj3 = ele4.getAsJsonObject();
										String teacher = obj3.get("last_name").getAsString() + "," + obj3.get("first_name").getAsString();
										if(!contains(code,teacher,classes)) {
											SCholasticClass c = new SCholasticClass(name, code, teacher);
											classes.add(c);
										}
									}
								}
								else {
									String teacher = obj2.get("instructor").getAsJsonObject().get("last_name").getAsString() + "," + obj2.get("instructor").getAsJsonObject().get("first_name").getAsString();
									if(!contains(code,teacher,classes)) {
										SCholasticClass c = new SCholasticClass(name, code, teacher);
										classes.add(c);
									}
								}
							}
						}
						else {
							JsonObject obj2 = temp.getAsJsonObject();
							JsonElement ele3 = obj2.get("instructor");
							if(ele3==null)
								continue;
							if(ele3.isJsonArray()) {
								JsonArray teachers = ele3.getAsJsonArray();
								for(JsonElement ele4 : teachers) {
									JsonObject obj3 = ele4.getAsJsonObject();
									String teacher = obj3.get("last_name").getAsString() + "," + obj3.get("first_name").getAsString();
									if(!contains(code,teacher,classes)) {
										SCholasticClass c = new SCholasticClass(name, code, teacher);
										classes.add(c);
									}
								}
							}
							else {
								String teacher = obj2.get("instructor").getAsJsonObject().get("last_name").getAsString() + "," + obj2.get("instructor").getAsJsonObject().get("first_name").getAsString();
								if(!contains(code,teacher,classes)) {
									SCholasticClass c = new SCholasticClass(name, code, teacher);
									classes.add(c);
								}
							}
						}
					}
				}
			}
		}
	}
	
	public static void teacherSearch(String query, String term, ArrayList<SCholasticClass> classes) {
		ArrayList<String> departments  = getDepartments(term);
		System.out.println(departments);
		for(String dept: departments) {
			JsonObject body = getDepartment(dept, term);
			if(body == null)
				continue;
			JsonObject offered = body.get("OfferedCourses").getAsJsonObject();
			JsonElement listele = offered.get("course");
			if(listele.isJsonArray()) {
				JsonArray listarr = listele.getAsJsonArray();
				for (JsonElement ele : listarr) {
					JsonObject obj = ele.getAsJsonObject();
					String name = obj.get("CourseData").getAsJsonObject().get("title").getAsString();
					String code = obj.get("CourseData").getAsJsonObject().get("prefix").getAsString() + "-"
							+ obj.get("CourseData").getAsJsonObject().get("number").getAsString();
						JsonElement temp = obj.get("CourseData").getAsJsonObject().get("SectionData");
						if(temp.isJsonArray()) {
							JsonArray sections = temp.getAsJsonArray();
							for(JsonElement section : sections) {
								JsonObject obj2 = section.getAsJsonObject();
								JsonElement ele3 = obj2.get("instructor");
								if(ele3==null)
									continue;
								if(ele3.isJsonArray()) {
									JsonArray teachers = ele3.getAsJsonArray();
									for(JsonElement ele4 : teachers) {
										JsonObject obj3 = ele4.getAsJsonObject();
										String teacher = obj3.get("last_name").getAsString() + "," + obj3.get("first_name").getAsString();
										if(teacher.toLowerCase().contains(query.toLowerCase()) && !contains(code,teacher,classes)) {
											SCholasticClass c = new SCholasticClass(name, code, teacher);
											classes.add(c);
										}
									}
								}
								else {
									String teacher = obj2.get("instructor").getAsJsonObject().get("last_name").getAsString() + "," + obj2.get("instructor").getAsJsonObject().get("first_name").getAsString();
									if(teacher.toLowerCase().contains(query.toLowerCase()) && !contains(code,teacher,classes)) {
										SCholasticClass c = new SCholasticClass(name, code, teacher);
										classes.add(c);
									}
								}
							}
						}
						else {
							JsonObject obj2 = temp.getAsJsonObject();
							JsonElement ele3 = obj2.get("instructor");
							if(ele3==null)
								continue;
							if(ele3.isJsonArray()) {
								JsonArray teachers = ele3.getAsJsonArray();
								for(JsonElement ele4 : teachers) {
									JsonObject obj3 = ele4.getAsJsonObject();
									String teacher = obj3.get("last_name").getAsString() + "," + obj3.get("first_name").getAsString();
									if(teacher.toLowerCase().contains(query.toLowerCase()) && !contains(code,teacher,classes)) {
										SCholasticClass c = new SCholasticClass(name, code, teacher);
										classes.add(c);
									}
								}
							}
							else {
								String teacher = obj2.get("instructor").getAsJsonObject().get("last_name").getAsString() + "," + obj2.get("instructor").getAsJsonObject().get("first_name").getAsString();
								if(teacher.toLowerCase().contains(query.toLowerCase()) && !contains(code,teacher,classes)) {
									SCholasticClass c = new SCholasticClass(name, code, teacher);
									classes.add(c);
								}
							}
						}
				}
			}
		}
	}
	
	public static boolean contains(String coursecode, String teacher, ArrayList<SCholasticClass> classes) {
		for(SCholasticClass c: classes) {
			if(c.coursecode.equals(coursecode) && c.teacher.equals(teacher))
				return true;
		}
		return false;
	}
	
	
	
}