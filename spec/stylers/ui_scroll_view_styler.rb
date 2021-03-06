class StyleSheetForUIViewStylerTests < RubyMotionQuery::Stylesheet

  def ui_scroll_view_kitchen_sink(st)
    st.paging = st.paging
    st.paging = true

    st.scroll_enabled = st.scroll_enabled
    st.scroll_enabled = false

    st.direction_lock = st.direction_lock
    st.direction_lock = true

    st.content_inset = st.content_inset
    st.content_inset = UIEdgeInsetsMake(1, 2, 3, 4)

    st.indicator_style = UIScrollViewIndicatorStyleDefault
  end

  # We have to test contentOffset separately from contentInset
  # because setting contentInset modifies contentOffset.
  def ui_scroll_view_content_offset(st)
    st.content_offset = st.content_offset
    st.content_offset = CGPointMake(12, 12)
  end

  def ui_scroll_view_white_indicators(st)
    st.indicator_style = :white
  end

end

describe 'stylers/ui_scroll_view' do
  before do
    @vc = UIViewController.alloc.init
    @vc.rmq.stylesheet = StyleSheetForUIViewStylerTests
    @view_klass = UIScrollView
  end

  behaves_like "styler"

  it 'should apply a style with every UIScrollViewStyler wrapper method' do
    view = @vc.rmq.append(@view_klass, :ui_scroll_view_kitchen_sink).get

    view.tap do |v|
      v.isPagingEnabled.should == true
      v.isScrollEnabled.should == false
      v.isDirectionalLockEnabled.should == true
      v.contentInset.should == UIEdgeInsetsMake(1, 2, 3, 4)
      v.indicatorStyle.should == UIScrollViewIndicatorStyleDefault
    end

    view = @vc.rmq.append(@view_klass, :ui_scroll_view_content_offset).get
    view.tap do |v|
      v.contentOffset.should == CGPointMake(12, 12)
    end

    view = @vc.rmq.append(@view_klass, :ui_scroll_view_white_indicators).get
    view.tap do |v|
      v.indicatorStyle.should == UIScrollViewIndicatorStyleWhite
    end

  end
end
