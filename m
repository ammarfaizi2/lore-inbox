Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132692AbRAGOA3>; Sun, 7 Jan 2001 09:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132685AbRAGOAN>; Sun, 7 Jan 2001 09:00:13 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:11144 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S132683AbRAGN7w>; Sun, 7 Jan 2001 08:59:52 -0500
Date: Sun, 7 Jan 2001 15:00:25 +0100 (CET)
From: Matthias Juchem <matthias@gandalf.math.uni-mannheim.de>
Reply-To: Matthias Juchem <juchem@uni-mannheim.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new bug report script
In-Reply-To: <E14FGKh-0002gh-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0101071457540.7104-100000@gandalf.math.uni-mannheim.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jan 2001, Alan Cox wrote:

> The kernel doesnt require perl. I don't want to add a dependancy on perl

Well, I wouldn't be a dependancy as you do not have to use it. Why not add
it as an option. I guess most of the installations have a perl
interpreter.

BTW:
# find . -name \*.pl
./drivers/scsi/script_asm.pl
./drivers/usb/serial/ezusb_convert.pl
./arch/ppc/treeboot/elf.pl
./arch/arm/lib/extractconstants.pl
./scripts/checkconfig.pl
./scripts/checkhelp.pl
./scripts/checkincludes.pl

Matthias

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
