Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131061AbRAQANA>; Tue, 16 Jan 2001 19:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130563AbRAQAMu>; Tue, 16 Jan 2001 19:12:50 -0500
Received: from maniola.plus.net.uk ([195.166.135.195]:38837 "HELO
	mail.plus.net.uk") by vger.kernel.org with SMTP id <S129994AbRAQAMh>;
	Tue, 16 Jan 2001 19:12:37 -0500
From: "D.W.Howells" <dhowells@astarte.free-online.co.uk>
To: linux-kernel@vger.kernel.org
Subject: What happened to merge_segments()?
Date: Tue, 16 Jan 2001 23:05:13 +0000
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <01011623051300.02633@orion.ddi.co.uk>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can someone tell me what happened to the merge_segments() function in 
mm/mmap.c? I was using it in my Wine accelerator module, but it's no longer 
present.

Cheers,
David
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
