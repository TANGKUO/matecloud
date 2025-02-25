package vip.mate.system.entity;

import com.baomidou.mybatisplus.annotation.TableName;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import vip.mate.core.database.entity.BaseEntity;

/**
 * <p>
 * 组织机构表
 * </p>
 *
 * @author xuzf
 * @since 2020-06-28
 */
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName("mate_sys_depart")
public class SysDepart extends BaseEntity {

    private static final long serialVersionUID=1L;

    /**
     * 部门名称
     */
    private String name;

    /**
     * 排序
     */
    private Integer sort;

//    /**
//     * 创建人
//     */
//    private String createBy;
//
//    /**
//     * 更新人
//     */
//    private String updateBy;

//    /**
//     * 创建时间
//     */
//    private LocalDateTime createTime;
//
//    /**
//     * 修改时间
//     */
//    private LocalDateTime updateTime;

    /**
     * 删除标识
     */
    private String isDeleted;

    /**
     * 上级ID
     */
    private Long parentId;

    /**
     * 租户ID
     */
    private Long tenantId;


}
