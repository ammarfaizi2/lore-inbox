Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbUB1SZP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 13:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbUB1SZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 13:25:15 -0500
Received: from 0x50c49cd1.adsl-fixed.tele.dk ([80.196.156.209]:9988 "EHLO
	redeeman") by vger.kernel.org with ESMTP id S261899AbUB1SZM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 13:25:12 -0500
Message-ID: <1059.192.168.1.7.1077992711.squirrel@mail.redeeman.linux.dk>
Date: Sat, 28 Feb 2004 19:25:11 +0100 (CET)
Subject: amd64_gart problems
From: "Redeeman" <redeeman@metanurb.dk>
To: linux-kernel@vger.kernel.org
Reply-To: redeeman@metanurb.dk
User-Agent: SquirrelMail/1.4.2
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mime-Autoconverted: from 8bit to 7bit by courier 0.44
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi, i am having some problems with the amd64 oncpu agpgart, on my asus k8v
deluxe board, and amd64 3200+ cpu. my motherboard has via k8t800 chipset,
and i use the oncpu gart together with my via agpgart. when i only compile
in support for via chipset my performance isnt as good as with oncpu gart.
but with oncpu gart enabled my system is quite unstable, X just freezes,
and i have to sync my disc with sysrq, and then hard reset.

any ideas?

/Redeeman.

