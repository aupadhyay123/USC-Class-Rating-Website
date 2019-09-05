package ReviewClass;

import java.io.Serializable;

public class SCholasticClass implements Comparable<SCholasticClass>, Serializable {

	private static final long serialVersionUID = 1L;
	public int id;
	public String name, coursecode, teacher;
	public boolean rated = false;

	public SCholasticClass(String name, String coursecode, String teacher) {
		this.name = name;
		this.coursecode = coursecode;
		this.teacher = teacher;
	}

	@Override
	public int compareTo(SCholasticClass other) {
		if (other instanceof RatedClass && !(this instanceof RatedClass)) {
			return 1;
		} else if (this instanceof RatedClass && !(other instanceof RatedClass)) {
			return -1;
		} else if (this instanceof RatedClass && other instanceof RatedClass) {
			RatedClass rc1 = (RatedClass) this;
			RatedClass rc2 = (RatedClass) other;
			return (int) (rc2.score - rc1.score);
		}
		return teacher.compareTo((other).teacher);
	}
	

}