Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129734AbQJ0MF3>; Fri, 27 Oct 2000 08:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130146AbQJ0MFT>; Fri, 27 Oct 2000 08:05:19 -0400
Received: from zeus.kernel.org ([209.10.41.242]:44036 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129734AbQJ0MFI>;
	Fri, 27 Oct 2000 08:05:08 -0400
Subject: Re: NFS, Can't get request slot
To: jordg@cpgen.cpg.com.au (Grahame Jordan)
Date: Fri, 27 Oct 2000 12:40:31 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <39F904AA.A585C3FF@cpgen.cpg.com.au> from "Grahame Jordan" at Oct 27, 2000 03:29:30 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13p7sA-0004M5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> By the evidence that we have gathered it seems that the Server is not
> taxed too much as samba users are getting files OK etc.  The can't get
> request slot is plaguing many others in different ways.   It looks like
> an NFS issue.   How can this be proven?  Then we can work on the
> problem.

The request queue slot message means the server isnt responding (at least in
the eyes of the client). Given you can get into the box that isnt the
net card (at least not now). What mount options do you use ?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
