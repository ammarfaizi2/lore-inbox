Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131657AbRCXMoF>; Sat, 24 Mar 2001 07:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131658AbRCXMny>; Sat, 24 Mar 2001 07:43:54 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:56046 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S131657AbRCXMno>; Sat, 24 Mar 2001 07:43:44 -0500
Message-Id: <l03130317b6e246476b8b@[192.168.239.101]>
In-Reply-To: <Pine.LNX.4.33.0103241039590.2310-100000@mikeg.weiden.de>
In-Reply-To: <3ABC5143.167A649E@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sat, 24 Mar 2001 12:42:00 +0000
To: Mike Galbraith <mikeg@wen-online.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: [PATCH] Prevent OOM from killing init
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>General thread comment:
>To those who are griping, and obviously rightfully so, Rik has twice
>stated on this list that he could use some help with VM auto-balancing.
>The responses (visible on this list at least) was rather underwhelming.
>I noted no public exchange of ideas.. nada in fact.
>
>Get off your lazy butts and do something about it.  Don't work on the
>oom-killer though.. that's only a symptom.  Work on the problem instead.

Since I'm hacking around in this area anyway (warning: kernel newbie
alert!), I'd be happy to help examine the balancing code from a fresh
perspective.  Where should I be looking?

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


