Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131400AbRDBWRU>; Mon, 2 Apr 2001 18:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131407AbRDBWRK>; Mon, 2 Apr 2001 18:17:10 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:31249 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131400AbRDBWQz>; Mon, 2 Apr 2001 18:16:55 -0400
Subject: Re: PROBLEM:Bug when installing NVidia Driver Module
To: gregvb@theblackfire.net (Greg von Beck)
Date: Mon, 2 Apr 2001 23:18:01 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0104011147300.10910-100000@www.theblackfire.net> from "Greg von Beck" at Apr 01, 2001 12:07:22 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14kCeC-0006pD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> /lib/modules/2.4.3/video/NVDriver: unresolved symbol _mmx_memcpy
> 
> however if i rebuild my kernel using an "i686" architecture this problem
> no longer comes up.
> 
> It is quite possible that this is NVidia's problem, however it seemed
> reasonable that the "athlon" architecture should support MMX.

Take it up with Nvidia - its (as usual) their problem
