Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292855AbSBVNJf>; Fri, 22 Feb 2002 08:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292857AbSBVNJP>; Fri, 22 Feb 2002 08:09:15 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:49679 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292855AbSBVNJM>; Fri, 22 Feb 2002 08:09:12 -0500
Subject: Re: error with =?ISO-8859-1?Q?binfmt=B4s?= modules
To: buzz@linuxbr.com.br
Date: Fri, 22 Feb 2002 13:20:34 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200202221145.g1MBjkj05721@www5.mailbr.com.br> from "=?ISO-8859-1?Q?=DFuzzLinux?=" at Feb 22, 2002 12:13:32 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16eFco-0001r0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When I try to add binfmt_misc.o modules he says: device or resource 
> busy, and with the red hat 7.2 kernel (2.4.7-10) I could add with no 
> error this modules

Works here..

> The binfmt_elf.o modules return unresolved symbols.

Which symbols ?

> And, when I try to enter boot teh vmlinuz-2.4.17 it returns a fatal 
> error:
> kmod: /sbin/modprobe -s -k binfmt*****.....

Well yes it would. What format do you think /sbin/modprobe is in ?
