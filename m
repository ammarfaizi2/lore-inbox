Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275207AbRJAQSB>; Mon, 1 Oct 2001 12:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275203AbRJAQRv>; Mon, 1 Oct 2001 12:17:51 -0400
Received: from blackhole.adamant.net ([212.26.128.69]:61490 "EHLO
	blackhole.adamant.net") by vger.kernel.org with ESMTP
	id <S275210AbRJAQRo>; Mon, 1 Oct 2001 12:17:44 -0400
Date: Mon, 1 Oct 2001 19:18:06 +0300
From: Alexander Trotsai <mage@adamant.net>
To: linux-kernel@vger.kernel.org
Subject: gcc v2.96 vs v3.01
Message-ID: <20011001191806.P6514@blackhole.adamant.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Organization: Adamant ISP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All

Why when I try to make kernel with 3.01 I got
net/network.o: In function `inet_dump_rules':
net/network.o(.text+0x3a8dd): undefined reference to `inet_fill_rule'
when try to link vmlinux?
But with 2.96 linux compile and link Ok

-- 
UaNic: MAGE1-UANIC, RIPE: MAGE-RIPE, InterNic: AT2963, ICQ: 18035130
PGP: ftp://blackhole.adamant.net/pgp/mykey.pgp.asc
Big trouble -  Digital Manipulator exceeding velocity parameters
