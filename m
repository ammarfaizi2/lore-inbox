Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbVDBWvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbVDBWvH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 17:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbVDBWvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 17:51:06 -0500
Received: from mtl.rackplans.net ([65.39.167.249]:11744 "HELO innerfire.net")
	by vger.kernel.org with SMTP id S261316AbVDBWt4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 17:49:56 -0500
Date: Sat, 2 Apr 2005 17:24:53 -0500 (EST)
From: Gerhard Mack <gmack@innerfire.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.11.6: Mach64 driver spams the console
Message-ID: <Pine.LNX.4.58.0504021723330.15788@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can someone please explain why I get this every time I switch in and out
of X?  And better yet how do I turn this off?

debug atyfb: Mach64 non-shadow register values:
debug atyfb: 0x2000:  004F0063 000C0052 01DF020C 000201EA
debug atyfb: 0x2010:  016F0000 14000000 00000020 0B002200
debug atyfb: 0x2020:  005B04BC 0068048E 00000000 00382848
debug atyfb: 0x2030:  00000000 00200213 00000000 0000C001
debug atyfb: 0x2040:  00000000 00000000 00000000 0450098B
debug atyfb: 0x2050:  04C506DB 00000000 00000000 00000000
debug atyfb: 0x2060:  00000000 AAAAAA0F 0007FE00 00300088
debug atyfb: 0x2070:  00300000 00000000 00003700 48833800
debug atyfb: 0x2080:  04900400 00000000 0F0B000C 00020002
debug atyfb: 0x2090:  00803003 00000000 0A000100 00000000
debug atyfb: 0x20A0:  7B23A050 00000107 00006001 E5000CF1
debug atyfb: 0x20B0:  00165A27 00010000 00010000 00000000
debug atyfb: 0x20C0:  00FF0010 86010182 00000000 00000000
debug atyfb: 0x20D0:  00000100 007F0179 00000000 00003F02
debug atyfb: 0x20E0:  65004752 00410096 00000000 00000000
debug atyfb: 0x20F0:  00000000 0000F6FE FB8004F8 00000000

debug atyfb: Mach64 PLL register values:
debug atyfb: 0x00:  ADD51FE4 8103FFDA F500DA0A 801B0000
debug atyfb: 0x10:  00CF4000 10ADAC10 400024FD 00000002
debug atyfb: 0x20:  06AC0610 1424FD00 00195500 00000000
debug atyfb: 0x30:  00000000 00000000 00000000 00000000


--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.
