Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLKDXz>; Sun, 10 Dec 2000 22:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129226AbQLKDXp>; Sun, 10 Dec 2000 22:23:45 -0500
Received: from uberbox.mesatop.com ([208.164.122.11]:44549 "EHLO
	uberbox.mesatop.com") by vger.kernel.org with ESMTP
	id <S129183AbQLKDXi>; Sun, 10 Dec 2000 22:23:38 -0500
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: linux-kernel@vger.kernel.org
Subject: Re: more compile errors, test12-pre8 and reiserfs
Date: Sun, 10 Dec 2000 19:54:09 -0700
X-Mailer: KMail [version 1.1.95.2]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <00121019540901.01210@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford wrote:
>journal.c: In function `reiserfs_journal_commit_thread':
>journal.c:1816: invalid operands to binary !=

Just before that error, I also got this:

journal.c: In function `setup_commit_task_arg':
journal.c:1765: structure has no member named `next'

Steven
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
