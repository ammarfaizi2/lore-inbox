Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131103AbQLJAEB>; Sat, 9 Dec 2000 19:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131989AbQLJADz>; Sat, 9 Dec 2000 19:03:55 -0500
Received: from 513.holly-springs.nc.us ([216.27.31.173]:1556 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S131103AbQLJADa>; Sat, 9 Dec 2000 19:03:30 -0500
Message-ID: <3A32C128.1ED29FA2@holly-springs.nc.us>
Date: Sat, 09 Dec 2000 18:32:56 -0500
From: Michael Rothwell <rothwell@holly-springs.nc.us>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.18pre21 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.18 almost...
In-Reply-To: <E144syy-0005sE-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> The patch I intend to be 2.2.18 is out as 2.2.18pre26 in the usual place.
> I'll move it over tomorrow if nobody reports any horrors, missing files etc


Fresh 2.2.17, "patch -p1 < /pre-patch-2.2.18-26"

can't find file to patch at input line 38909
Perhaps you used the wrong -p or --strip option?
The text leading up to this was:
--------------------------
|diff -u --new-file --recursive --exclude-from /usr/src/exclude
v2.2.17/arch/i386/vmlinux.lds linux/arch/i386/vmlinux.lds
|--- v2.2.17/arch/i386/vmlinux.lds	Wed May  3 21:22:13 2000
|+++ linux/arch/i386/vmlinux.lds	Sat Dec  9 21:23:21 2000
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
