Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132757AbRDNGDe>; Sat, 14 Apr 2001 02:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132756AbRDNGDY>; Sat, 14 Apr 2001 02:03:24 -0400
Received: from turnover.lancs.ac.uk ([148.88.17.220]:41469 "EHLO
	helium.chromatix.org.uk") by vger.kernel.org with ESMTP
	id <S132757AbRDNGDR>; Sat, 14 Apr 2001 02:03:17 -0400
Message-Id: <l03130308b6fd940e8984@[192.168.239.105]>
In-Reply-To: <Pine.LNX.4.21.0104131916150.11797-100000@freak.mileniumnet.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sat, 14 Apr 2001 06:44:19 +0100
To: Thiago Rondon <maluco@mileniumnet.com.br>,
        lkml <linux-kernel@vger.kernel.org>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: [QUESTION] init/main.c
Cc: "Michael A. Griffith" <grif@acm.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>ticks = jiffies; while (ticks == jiffies); ticks = jiffies; ?

jiffies is updated by an interrupt routine, I think.

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


