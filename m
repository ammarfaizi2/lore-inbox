Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266922AbUBMKvC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 05:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266925AbUBMKvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 05:51:01 -0500
Received: from mail.gmx.net ([213.165.64.20]:22403 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266922AbUBMKu7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 05:50:59 -0500
Date: Fri, 13 Feb 2004 11:50:58 +0100 (MET)
From: "Daniel Blueman" <daniel.blueman@gmx.net>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Re: ICH5 with 2.6.1 very slow
X-Priority: 3 (Normal)
X-Authenticated: #8973862
Message-ID: <14781.1076669458@www11.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Did you try replacing the two IDE cables you have with new 30cm 80 way
ones? IDE can hide marginal cables with CRC-checking and retrying.

What about swapping them, and/or swapping the drives around, then
comparing the transfer rate of /dev/hda and /dev/hdc again?

"Kyle" <kyle@southa.com> wrote in message
news:<1oClr-6j-15@gated-at.bofh.it>...
> It's already in "Enhanced mode", tried "legacy" and "combined" as well, no
> help.

-- 
Daniel J Blueman

GMX ProMail (250 MB Mailbox, 50 FreeSMS, Virenschutz, 2,99 EUR/Monat...)
jetzt 3 Monate GRATIS + 3x DER SPIEGEL +++ http://www.gmx.net/derspiegel +++

