Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262975AbTCWIcv>; Sun, 23 Mar 2003 03:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262976AbTCWIcv>; Sun, 23 Mar 2003 03:32:51 -0500
Received: from [65.214.160.163] ([65.214.160.163]:61320 "EHLO rimmer.65535.net")
	by vger.kernel.org with ESMTP id <S262975AbTCWIcu>;
	Sun, 23 Mar 2003 03:32:50 -0500
Date: Sun, 23 Mar 2003 08:43:40 +0000 (GMT)
From: meyers_j@freeshell1.65535.net
X-X-Sender: meyers_j@rimmer.65535.net
To: linux-kernel@vger.kernel.org
Subject: sound card
Message-ID: <Pine.LNX.4.44.0303230840001.25376-100000@rimmer.65535.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know exactly which  card is on my friends board

i thought it is soundblaster and tried ioport=0x220 which i found on the
net.But it didn't work.SO is there any way of finding the address ?
or any list to guess 0x230 etc

pnpdump shows
# Trying port address 03ab
# Trying port address 03b3
# Trying port address 03bb
# Trying port address 03e3
# Trying port address 03eb
# Trying port address 03f3
# No boards found

I cut the above ports

i tried sndconfig but didn't work

P.S. CC me

