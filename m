Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130122AbRBSQRE>; Mon, 19 Feb 2001 11:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130269AbRBSQQy>; Mon, 19 Feb 2001 11:16:54 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:31761 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130122AbRBSQQk>; Mon, 19 Feb 2001 11:16:40 -0500
Subject: Re: Proliant hangs with 2.4 but works with 2.2.
To: lafanga1@hotmail.com (lafanga lafanga)
Date: Mon, 19 Feb 2001 16:17:06 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <F223BDXmDQOa8NlgXjs0000598e@hotmail.com> from "lafanga lafanga" at Feb 19, 2001 02:39:42 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Uszs-0003nY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'll be happy to test out 2.2.19pre. I'm having a little difficulty locating 
> it though on kernel.org. Can you or somebody send me a URL for this.

ftp://ftp.kernel.org/pub/linux/kernel/people/alan/...

each 2.2.19pre patch is versus the 2.2.18 base

ie

	tar xvfz linux-2.2.18.tar.gz
	cd linux
	patch -p1 <../patch-2.2.19prefoo

