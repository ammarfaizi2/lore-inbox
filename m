Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131466AbRBJOjc>; Sat, 10 Feb 2001 09:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131468AbRBJOjW>; Sat, 10 Feb 2001 09:39:22 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:17060 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S131466AbRBJOjP>; Sat, 10 Feb 2001 09:39:15 -0500
Message-Id: <l03130317b6aafe7be844@[192.168.239.101]>
In-Reply-To: <20010210143046.A2164@albireo.ucw.cz>
In-Reply-To: <20010209173600.A2887@suse.cz>; from vojtech@suse.cz on Fri,
 Feb 09, 2001 at 05:36:00PM +0100 <1500B3C52526@vcnet.vc.cvut.cz>
 <20010209173600.A2887@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sat, 10 Feb 2001 14:21:28 +0000
To: linux-kernel@vger.kernel.org
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: [preview] VIA IDE 4.0 and AMD IDE 2.0 with automatic PC
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Not the case, sorry. An IDE drive is needed. However, it still might be
>> worth to pass the PCI speed to other drivers ...
>
>But beware, the timing should be a per-bus value.

Indeed - remember the PowerMac G3 (blue & white) and the "Yikes" G4 have a
66MHz PCI slot in place of the AGP slot used in later G4s, with the
remaining 3 PCI slots being 33MHz 64-bit.

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r- y+
-----END GEEK CODE BLOCK-----


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
