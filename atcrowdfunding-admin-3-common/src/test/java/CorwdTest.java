import com.atguigu.crowd.funding.util.CrowdFundingUtils;
import org.junit.Test;

public class CorwdTest {

    @Test
    public void testMD5(){

        String source = "123123";

        String target = CrowdFundingUtils.md5(source);

        System.out.println(target);
    }
}
