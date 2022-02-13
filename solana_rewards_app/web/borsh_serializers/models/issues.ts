export class Issue {
    title: string;
    description: string;
    reward: number;
    issue_type: IssueType;
    state: IssueState;
    attachments: String[];

    constructor(
        fields: {
            title: string;
            description: string;
            reward: number;
            issue_type: IssueType;
            state: IssueState;
            attachments: String[];
        }
    ) {
        this.title = fields.title;
        this.description = fields.description;
        this.reward = fields.reward;
        this.issue_type = fields.issue_type;
        this.state = fields.state;
        this.attachments = fields.attachments;
    }
}

export enum IssueType {
    Thrash,
    Road
}

export enum IssueState {
    Processing,
    Uploaded,
    Accepted,
    Solving,
    Solved,
    Rejected,
    Error
}

export const IssueSchema = new Map([
    [
        Issue,
        {
            kind: "struct",
            fields: [
                ["title", "string"],
                ["description", "string"],
                ["reward", "u64"],
                ["issue_type", "u8"],
                ["state", "u8"],
                ["state", "u8"],
                ["attachments", ["string"]],
            ],
        },
    ],
]);