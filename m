Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312498AbSDEMVl>; Fri, 5 Apr 2002 07:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312499AbSDEMVb>; Fri, 5 Apr 2002 07:21:31 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1798 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312498AbSDEMVU>; Fri, 5 Apr 2002 07:21:20 -0500
Subject: Re: Kernel BUG at inode.c:384!
To: sunadm@rediffmail.com
Date: Fri, 5 Apr 2002 13:38:26 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020405084200.13305.qmail@mailweb18.rediffmail.com> from "Umaid Singh Rajpurohit" at Apr 05, 2002 08:42:00 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16tSz4-0008CD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> we are running clearcase,sun grid engine on RedHat Linux 7.1 
> (kernel 2.4.2-2smp) on IBM Xseries one U servers that has

Are you running the clearcase binary modules ? If so then please take your
bug to clearcase, or your vendor.

> Linux  2.4.2-2smp #1 SMP Sun Apr 8 20:21:34 EDT 2001 i686 
> unknown

You should upgrade that kernel anyway both for performance and if relevant
in your environment for security reasons

Alan
