Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130865AbRANUjH>; Sun, 14 Jan 2001 15:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131392AbRANUi4>; Sun, 14 Jan 2001 15:38:56 -0500
Received: from chiara.elte.hu ([157.181.150.200]:11280 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S130865AbRANUit>;
	Sun, 14 Jan 2001 15:38:49 -0500
Date: Sun, 14 Jan 2001 21:38:23 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <93t1q7$49c$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0101142136330.4111-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 14 Jan 2001, Linus Torvalds wrote:

> Does anybody but apache actually use it?

There is a Samba patch as well that makes it sendfile() based. Various
other projects use it too (phttpd for example), some FTP servers i
believe, and khttpd and TUX.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
