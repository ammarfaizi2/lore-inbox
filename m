Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265534AbRFVVtO>; Fri, 22 Jun 2001 17:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265535AbRFVVsy>; Fri, 22 Jun 2001 17:48:54 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:3854 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265534AbRFVVsv>; Fri, 22 Jun 2001 17:48:51 -0400
Subject: Re: For comment: draft BIOS use document for the kernel
To: bgerst@didntduck.org (Brian Gerst)
Date: Fri, 22 Jun 2001 22:46:22 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), root@chaos.analogic.com,
        RSchilling@affiliatedhealth.org (Schilling Richard),
        linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <3B338C2B.D036012F@didntduck.org> from "Brian Gerst" at Jun 22, 2001 02:19:23 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15DYkw-0004CB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's in arch/i386/boot/setup.S, after label bootsect_second.  It's only
> used with bzImage kernels and the floppy bootsector.

I stand corrected. I will add this to the documentation

Alan

