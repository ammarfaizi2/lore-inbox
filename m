Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132759AbRDNGDY>; Sat, 14 Apr 2001 02:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132756AbRDNGDO>; Sat, 14 Apr 2001 02:03:14 -0400
Received: from turnover.lancs.ac.uk ([148.88.17.220]:37117 "EHLO
	helium.chromatix.org.uk") by vger.kernel.org with ESMTP
	id <S132754AbRDNGDJ>; Sat, 14 Apr 2001 02:03:09 -0400
Message-Id: <l03130306b6fd91eb090c@[192.168.239.105]>
In-Reply-To: <3AD78A6C.F0F3CF5A@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sat, 14 Apr 2001 06:35:56 +0100
To: joeja@mindspring.com, linux-kernel@vger.kernel.org
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: bug in float on Pentium
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> double x = 5483.99;
> float y = 5483.99;

>5483.990000
>5483.990234

Well, duh.  Floats are less accurate than doubles, so what?  Read your C
textbook again.

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


