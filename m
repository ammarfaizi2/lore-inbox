Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131369AbQLJAHv>; Sat, 9 Dec 2000 19:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131912AbQLJAHm>; Sat, 9 Dec 2000 19:07:42 -0500
Received: from DKBH-T-003-p-249-97.tmns.net.au ([203.54.249.97]:61201 "EHLO
	eyal.emu.id.au") by vger.kernel.org with ESMTP id <S131369AbQLJAHa>;
	Sat, 9 Dec 2000 19:07:30 -0500
Message-ID: <3A32C205.E773B900@eyal.emu.id.au>
Date: Sun, 10 Dec 2000 10:36:37 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.18 almost...
In-Reply-To: <E144syy-0005sE-00@the-village.bc.nu> <20001209161254.H954@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2000 at 11:00:41PM +0000, Alan Cox wrote:

> The patch I intend to be 2.2.18 is out as 2.2.18pre26 in the usual place.
> I'll move it over tomorrow if nobody reports any horrors, missing files etc

The text leading up to this was:
--------------------------
|diff -u --new-file --recursive --exclude-from /usr/src/exclude
v2.2.17/arch/i386/vmlinux.lds linux/arch/i386/vmlinux.lds
|--- v2.2.17/arch/i386/vmlinux.lds      Wed May  3 21:22:13 2000
|+++ linux/arch/i386/vmlinux.lds        Sat Dec  9 21:23:21 2000
--------------------------
File to patch: 
Skip this patch? [y] y
1 out of 1 hunk ignored

--
Eyal Lebedinsky		(eyal@eyal.emu.id.au)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
