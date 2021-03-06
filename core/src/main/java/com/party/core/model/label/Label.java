package com.party.core.model.label;

import com.party.core.model.BaseModel;

/**
 * 标签实体
 * Created by wei.li
 *
 * @date 2017/7/7 0007
 * @time 15:43
 */
public class Label extends BaseModel {
    private static final long serialVersionUID = 6624953662424588910L;

    //标签名称
    private String name;

    //风格
    private String style;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getStyle() {
        return style;
    }

    public void setStyle(String style) {
        this.style = style;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        if (!super.equals(o)) return false;

        Label label = (Label) o;

        if (name != null ? !name.equals(label.name) : label.name != null) return false;
        return style != null ? style.equals(label.style) : label.style == null;

    }

    @Override
    public int hashCode() {
        int result = super.hashCode();
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (style != null ? style.hashCode() : 0);
        return result;
    }

    @Override
    public String toString() {
        return "Label{" +
                "name='" + name + '\'' +
                ", style='" + style + '\'' +
                '}';
    }
}
