Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129443AbRCZWI7>; Mon, 26 Mar 2001 17:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129460AbRCZWIu>; Mon, 26 Mar 2001 17:08:50 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:32189 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S129443AbRCZWIe>; Mon, 26 Mar 2001 17:08:34 -0500
Message-Id: <l0313032eb6e56cd8d6bb@[192.168.239.101]>
In-Reply-To: <200103262127.PAA24549@tomcat.admin.navo.hpc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 26 Mar 2001 23:07:17 +0100
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
        dalecki@evision-ventures.com,
        "Eric W. Biederman" <ebiederm@xmission.com>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: 64-bit block sizes on 32-bit systems
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>These are NOT the only 64 bit systems - Intel, PPC, IBM (in various guises).
>If you need raw compute power, the Alpha is pretty good (we have over a
>1000 in a Cray T3..).

Best of all, the PowerPC and the POWER are binary-compatible to a very
large degree - just the latter has an extra set of 64-bit instructions.
What was that I was hearing about having to redevelop or recompile your
apps for 64-bit?

I can easily imagine a 64-bit filesystem being accessed by a bunch of
RS/6000s and monitored using an old PowerMac.  Goodness, the PowerMac 9600
even has 6 PCI slots to put all those SCSI-RAID and Ethernet cards in.  :)

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
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
-----END GEEK CODE BLOCK-----


