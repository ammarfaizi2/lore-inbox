Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265080AbUATG6O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 01:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265168AbUATG6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 01:58:14 -0500
Received: from kruuna.helsinki.fi ([128.214.205.14]:59548 "EHLO
	kruuna.Helsinki.FI") by vger.kernel.org with ESMTP id S265080AbUATG6M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 01:58:12 -0500
From: Atro Tossavainen <atossava@cc.helsinki.fi>
Message-Id: <200401200658.i0K6wAlb025191@kruuna.Helsinki.FI>
Subject: Re: PROBLEM: Panic reading EFS CDs on SCSI CD drives through loop
In-Reply-To: <20040119091513.073d66fc.rddunlap@osdl.org> from "Randy.Dunlap"
 at "Jan 19, 2004 09:15:13 am"
To: linux-kernel@vger.kernel.org
Date: Tue, 20 Jan 2004 08:58:10 +0200 (EET)
Reply-To: Atro.Tossavainen@helsinki.fi
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy,

> |      It reads a few files, then panics on a large file.  If I am running
> |      X11, the only symptom I see is that the machine freezes totally and
> |      the Caps Lock and Scroll Lock lights on the keyboard start blinking.
> |      If I'm in the text console, it displays the message:
> | 
> | Kernel panic: scsi_free:Trying to free unused memory
> 
> Are there some other messages associated with this, like
> a BUG or stack dump?  Those could be helpful.

I did read the instructions for reporting kernel bugs and would certainly
have sent any such reports if the computer had produced them in the first
place.  There are none, but the bug appears to be completely reproducible.

If you don't have an EFS CD to test with, perhaps SGI won't mind if I
make you a copy of something completely out of date such as the IRIX
5.3 development option CD, which they are giving out for free anyway
these days.

-- 
Atro Tossavainen (Mr.)               / The Institute of Biotechnology at
Systems Analyst, Techno-Amish &     / the University of Helsinki, Finland,
+358-9-19158939  UNIX Dinosaur     / employs me, but my opinions are my own.
< URL : http : / / www . helsinki . fi / %7E atossava / > NO FILE ATTACHMENTS
