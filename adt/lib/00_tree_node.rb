require "byebug"


class PolyTreeNode

  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def value
    @value
  end

  def parent=(parent_node)
    #if old parent exist? delete self or child from children or []
    if @parent
      @parent.children.delete(self)
    end
    #assign new parent
    @parent = parent_node
    #return nil if new parent provided is nil
    return @parent unless @parent
    #access the empty or already populate children array of parent [] named parent_children
    parent_children = parent_node.children
    #shoveling our "self" or new child into new parent array "children []"
    #unless child is alreeady a child of parent
    parent_children << self unless parent_children.include?(self)
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    # raise an arror if child_node is not in self's (parents) child array
    raise "Not a child!" unless self.children.include?(child_node)
    child_node.parent = nil
   end

   def dfs(target_value)
     # base case
     return self if self.value == target_value
     # goes thru each node's children
     self.children.each do |child|
       # result is only either nil or the target_value
       result = child.dfs(target_value)
       # breaks out if result is target_value, if nil the line is skipped and
       # the next child is evaluated
       return result if result
     end
     # returns nil if there are no children and the block never runs
     nil
   end


  def bfs(target_value)
    queue = [self]

    until queue.empty?
      # evaluating the first node and shifting it out of the front
      current_node = queue.shift
      byebug
      # returns the current node immediately if it is the target_value
      return current_node if current_node.value == target_value
      # shovels the current node's children onto the end of queue
      queue << current_node.children
    end
  end
end
#
# --A--
# -B-C-

a = PolyTreeNode.new("a")
b = PolyTreeNode.new("b")
c = PolyTreeNode.new("c")

b.parent = a
c.parent = a

a.bfs("c")

# old_node = PolyTreeNode.new("b")
# new_node.children
