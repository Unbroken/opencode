import type { WebSocket } from "ws"

export const TERMINAL_NAME = "opencode"
export const HOST = "127.0.0.1"
export const PING = 30000

export type Msg =
  | {
      type: "register"
      pids: number[]
      port: number
      host?: string
      authorization?: string
    }
  | {
      type: "active"
    }

export type Link = {
  sock: WebSocket
  pids: number[]
  term?: number
  ready: boolean
  port: number
  host: string
  authorization?: string
}
