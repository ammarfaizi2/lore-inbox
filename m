Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135724AbRDSVkP>; Thu, 19 Apr 2001 17:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135727AbRDSVkB>; Thu, 19 Apr 2001 17:40:01 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:18704 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135726AbRDSVjf>; Thu, 19 Apr 2001 17:39:35 -0400
Subject: Re: A little problem.
To: xhai@CLEMSON.EDU (Hai Xu)
Date: Thu, 19 Apr 2001 22:41:28 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <002301c0c911$e77c6490$3cac7f82@crb50> from "Hai Xu" at Apr 19, 2001 04:47:09 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14qMB9-00089Z-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> and upgrade the Linux Kerenl from their original 2.2.16 to 2.2.18. But when
> I compile some modules, it said my kernel is 2.4.0. I check the
> /usr/include/linux/version.h as follows, found that it shows I am using
> Kernel 2.4.0.

No. It shows the headers your C compiler libraries are built againt. Which is
2.4 - and which is correct. It has nothing to do with the kernel you are 
running

