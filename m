Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263441AbRFFHyS>; Wed, 6 Jun 2001 03:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263435AbRFFHyJ>; Wed, 6 Jun 2001 03:54:09 -0400
Received: from turnover.lancs.ac.uk ([148.88.17.220]:58105 "EHLO
	helium.chromatix.org.uk") by vger.kernel.org with ESMTP
	id <S263406AbRFFHx5>; Wed, 6 Jun 2001 03:53:57 -0400
Message-Id: <l03130307b74390373d82@[192.168.239.105]>
In-Reply-To: <20010606081416.B15199@dev.sportingbet.com>
In-Reply-To: <3B1D8A82.63FA138C@247media.com>; from
 russell.leighton@247media.com on Tue, Jun 05, 2001 at 09:42:26PM -0400
 <Pine.LNX.4.33.0106051634540.8311-100000@heat.gghcwest.com>
 <3B1D8A82.63FA138C@247media.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 6 Jun 2001 08:47:37 +0100
To: Sean Hunter <sean@dev.sportingbet.com>,
        Russell Leighton <russell.leighton@247media.com>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: Break 2.4 VM in five easy steps
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>It seems bizarre that a 4GB machine with a working set _far_ lower than that
>should be dying from OOM and swapping itself to death, but that's life in 2.4
>land.

I posted a fix for the OOM problem long ago, and it didn't get integrated
(even after I sent Alan a separated-out version from the larger patch it
was embedded in).  I'm going to re-introduce it soon, and hope that it gets
a better hearing this time.

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


