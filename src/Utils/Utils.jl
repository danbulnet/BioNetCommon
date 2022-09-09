module Utils

export Opt, ROOT_DIR

Opt{T} = Union{T, Nothing}

const ROOT_DIR = dirname(Base.current_project())

end