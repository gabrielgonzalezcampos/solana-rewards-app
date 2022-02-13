import { serialize } from "borsh";
import { Issue, IssueSchema } from "../models/issues";

export function encodeIssue(issue: Issue): Buffer {
    return Buffer.from(serialize(IssueSchema, issue));
}

export function decodeIssue(buffer: Buffer) {
    /* const archive_id = lo.cstr("archive_id");
    const created_on = lo.cstr("created_on");
    const dataStruct = lo.struct(
      [archive_id, lo.seq(lo.u8(), 2), created_on, lo.seq(lo.u8(), 2)],
      "ChatMessage"
    );
    const ds = lo.seq(dataStruct, CHAT_MESSAGE_ELEMENTS_COUNT);
    const messages = ds.decode(sentAccount.data); */
}