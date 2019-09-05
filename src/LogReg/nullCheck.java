package LogReg;

public final class nullCheck {

	public static boolean isEmpty(String input) {
		if (input == null || input.trim().length() == 0) {
			return true;
		}
		return false;
	}
}
