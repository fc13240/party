package com.party.admin.biz.sign;

import com.google.common.base.Function;
import com.party.admin.biz.file.FileBizService;
import com.party.admin.web.dto.output.sign.SignProjectOutput;
import com.party.common.paging.Page;
import com.party.common.utils.LangUtils;
import com.party.core.model.sign.SignProjectAuthor;
import com.party.core.service.sign.ISignProjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 签到项目业务接口
 * Created by wei.li
 *
 * @date 2017/6/7 0007
 * @time 9:38
 */

@Service
public class SignProjectBizService {

    @Autowired
    private FileBizService fileBizService;

    @Autowired
    private ISignProjectService signProjectService;

    private static final String CODE_PATH = "/signProject/";

    private static final String url = "sign/sign_pro.html?id=";


    /**
     * 签到项目输出视图
     * @param signProjectAuthor 签到项目
     * @param page 分页参数
     * @return 签到项目
     */
    public List<SignProjectOutput> list(SignProjectAuthor signProjectAuthor, Page page){
        List<SignProjectAuthor> list = signProjectService.projectAuthorList(signProjectAuthor, page);
        List<SignProjectOutput> outputList = LangUtils.transform(list, new Function<SignProjectAuthor, SignProjectOutput>() {
            @Override
            public SignProjectOutput apply(SignProjectAuthor signProjectAuthor) {
                SignProjectOutput signProjectOutput = SignProjectOutput.transform(signProjectAuthor);
                String url = getQrCode(signProjectAuthor.getId(), signProjectAuthor.getCreateBy());
                signProjectOutput.setQrCode(url);
                return signProjectOutput;
            }
        });
        return outputList;
    }

    /**
     * 获取二维码
     * @param id 报名项目编号
     * @param memberId 创建者
     * @return 二维码
     */
    public String getQrCode(String id, String memberId){
        // Member member = RealmUtils.getCurrentUser();
        String path = memberId + CODE_PATH;
        String content = url + id;
        String qrCodeUrl = fileBizService.getFileEntity(id, path, content);
        return qrCodeUrl;
    }

}
