Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131339AbRCSCIH>; Sun, 18 Mar 2001 21:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131344AbRCSCH5>; Sun, 18 Mar 2001 21:07:57 -0500
Received: from senechalle.net ([207.18.229.15]:7614 "EHLO senechalle.net")
	by vger.kernel.org with ESMTP id <S131339AbRCSCHp>;
	Sun, 18 Mar 2001 21:07:45 -0500
Date: Sun, 18 Mar 2001 20:07:20 -0600 (CST)
From: asenec@senechalle.net
Message-Id: <200103190207.UAA13397@senechalle.net>
To: linux-kernel@vger.kernel.org
Subject: /proc/cpuinfo for Intel P4 D850GB
X-Sun-Charset: US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a 2.0.36 kernel the above-referenced mb
shows:

dragonwind:/proc# cat cpuinfo
processor	: 0
cpu		: ?86
model		: 386 SX/DX
vendor_id	: GenuineIntel

At the least, java breaks because of the '?' char.

Is the problem is due to the older 2.0.36 kernel,
or would the problem also present itself on a newer 2.2.x kernel?

Annette
