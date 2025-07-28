import streamlit as st

# 设置页面配置 - 这应该是st命令中的第一个命令
st.set_page_config(
    page_title="Aura 洞察平台 | 首页",
    page_icon="✨", # 可以是emoji或图片URL
    layout="wide", # 'centered' 或 'wide'
    initial_sidebar_state="expanded", # 'auto', 'expanded', 'collapsed'
)

# --- 欢迎页面内容 ---
st.title("✨ 欢迎使用 Aura 公共卫生洞察平台")
st.sidebar.success("请在上方选择一个演示模块。")

st.markdown(
    """
    **Aura** 是一个以知识图谱为核心的、服务于流行病防控和公共卫生资源规划的
    “情、指、行、态”四位一体决策支持系统。

    **👈 请从左侧的侧边栏选择一个模块开始您的探索之旅：**

    - **情 (Intelligence):** 汇集多源情报，构建知识网络。
    - **态 (Situation):** 感知全景态势，实现深度洞察。
    - **指 (Command):** 进行沙盘推演，辅助科学决策。
    - **行 (Action):** 复盘行动效果，完成决策闭环。

    ---
    *本项目当前处于原型演示阶段。*
"""
)