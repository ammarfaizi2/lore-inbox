Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267261AbTATAle>; Sun, 19 Jan 2003 19:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267695AbTATAle>; Sun, 19 Jan 2003 19:41:34 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:24732 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S267261AbTATAld>; Sun, 19 Jan 2003 19:41:33 -0500
From: Richard Stallman <rms@gnu.org>
To: Jamie Lokier <jamie@shareable.org>
CC: davids@webmaster.com, linux-kernel@vger.kernel.org
In-reply-to: <20030118075455.GB18969@bjl1.asuk.net> (message from Jamie Lokier
	on Sat, 18 Jan 2003 07:54:55 +0000)
Subject: Re: [OFFTOPIC] Is the repository of a GPL'd program itself under the GPL?
Reply-to: rms@gnu.org
References: <20030118051012.GA18720@bjl1.asuk.net> <20030118072337.AAA10729@shell.webmaster.com@whenever> <20030118075455.GB18969@bjl1.asuk.net>
Message-Id: <E18aQ95-0006UU-00@fencepost.gnu.org>
Date: Sun, 19 Jan 2003 19:50:35 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    > 	So then suppose the tool I use for modifying the source code 
    > unpacks/decrypts it, allows changes, and then packs/encrypts it 
    > again. Suppose further that this tool is proprietary and not 
    > available without onerous licensing requirements. Would you say 
    > releasing the source code thus packed/encrypted meets the GPL?

It is not the preferred form for editing the source code,
so it is not the real source code as defined by the GPL.

    However, this begs another question: the kernel source is GPL'd.  But
    is the _repository_ at bkbits.net GPL'd?

I believe the contents are all under the GPL.

					      And if so, do I have the
    right to demand a copy of the whole repository whenever I receive a
    binary kernel, or is that right restricted to the checked out files
    used to compile that kernel?

Whoever distributes a binary kernel to you has the obligation to 
offer you the complete source code corresponding to the binary.
Source code not used in producing that binary need not be
included.
