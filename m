Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129078AbRBYNUl>; Sun, 25 Feb 2001 08:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129112AbRBYNUb>; Sun, 25 Feb 2001 08:20:31 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:31675 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S129084AbRBYNUY>; Sun, 25 Feb 2001 08:20:24 -0500
Message-Id: <l03130308b6beb41f34af@[192.168.239.101]>
In-Reply-To: <3A986EDB.363639E7@coplanar.net>
In-Reply-To: <3A9842DC.B42ECD7A@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 25 Feb 2001 13:08:50 +0000
To: Jeremy Jackson <jerj@coplanar.net>, Jeff Garzik <jgarzik@mandrakesoft.com>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: New net features for added performance
Cc: netdev@oss.sgi.com,
        Linux Knernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 2:32 am +0000 25/2/2001, Jeremy Jackson wrote:
>Jeff Garzik wrote:
>
>(about optimizing kernel network code for busmastering NIC's)
>
>> Disclaimer:  This is 2.5, repeat, 2.5 material.
>
>Related question: are there any 100Mbit NICs with cpu's onboard?
>Something mainstream/affordable?(i.e. not 1G ethernet)
>Just recently someone posted asking some technical question about
>ARMlinux for and intel card with 2 1G ports, 8 100M ports,
>an onboard ARM cpu and 4 other uControllers... seems to me
>that ultimately the networking code should go in that direction:
>immagine having the *NIC* do most of this... no cache pollution problems...

Dunno, but the latest Motorola ColdFire microcontroller has Ethernet built
in.  I think it's even 100baseTX, but I could be mistaken.

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


