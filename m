Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131205AbRC0LWC>; Tue, 27 Mar 2001 06:22:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131209AbRC0LVx>; Tue, 27 Mar 2001 06:21:53 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:39126 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S131205AbRC0LVn>; Tue, 27 Mar 2001 06:21:43 -0500
Message-Id: <l03130331b6e6277ea3bd@[192.168.239.101]>
In-Reply-To: <3AC06651.1ECB7B5@math.ethz.ch>
In-Reply-To: <fa.it9nv9v.g08l8a@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 27 Mar 2001 12:19:35 +0100
To: cate@dplanet.ch, manfred@colorfullife.com
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: URGENT : System hands on "Freeing unused kernel memory: "
Cc: puckwork@madz.net, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I have 2 ideas:
>> * glibc corrupted
>> * did you downgrade the cpu?
>
>These happen frequently to me (when compiling and installing a
>new glibc)
>But in this case you would have other messages (IIRC something
>like
>respawn too fast).
>Thus the problem is not this!

How about running memtest86 - could be that a RAM module blew up or worked
loose and caused the initial crash and this misbehaviour both at once.

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


