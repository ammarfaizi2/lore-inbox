Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131395AbRCNPCZ>; Wed, 14 Mar 2001 10:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131396AbRCNPCQ>; Wed, 14 Mar 2001 10:02:16 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:47767 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S131395AbRCNPCC>; Wed, 14 Mar 2001 10:02:02 -0500
Message-Id: <l03130302b6d530a44df8@[192.168.239.101]>
In-Reply-To: <3AAF7AD1.D24E526C@baretta.com>
In-Reply-To: <Pine.LNX.4.33.0103070958110.1424-100000@mikeg.weiden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 14 Mar 2001 14:30:14 +0000
To: Alex Baretta <alex@baretta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: 5Mb missing...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> If crashes are routine on this machine, I'd recommend that you take
>> a serious look at your ram. (or if you're overclocking, don't)
>
>Crashes were routine, and I was not overclocking, so I took Mike's
>advice and bought a new 256MB DIMM. The computer hasn't crashed
>once since I installed it. Now, though, I have a curious though
>fairly irrelevant problem. My kernel apparently sees less RAM than
>I have.

The kernel itself takes up some RAM, which is simply subtracted from the
"total memory available" field in the memory summaries available to
user-mode processes.  This is perfectly normal.

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


