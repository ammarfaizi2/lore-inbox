Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314325AbSGMOne>; Sat, 13 Jul 2002 10:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314340AbSGMOnd>; Sat, 13 Jul 2002 10:43:33 -0400
Received: from h-64-105-137-27.SNVACAID.covad.net ([64.105.137.27]:27066 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S314325AbSGMOnb>; Sat, 13 Jul 2002 10:43:31 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 13 Jul 2002 07:46:06 -0700
Message-Id: <200207131446.HAA24611@adam.yggdrasil.com>
To: alan@lxorguk.ukuu.org.uk
Subject: Re: IDE/ATAPI in 2.5
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
|o       Not all ide cdrom devices are ATAPI capable
[...]

	Are there some non-ATAPI IDE CDROM's that
linux-2.5.25/drivers/ide/ide-cdrom.c supports?   I was under
the impression that ide-cdrom.c operated only through ATAPI.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
