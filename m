Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266425AbTAFFFr>; Mon, 6 Jan 2003 00:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266417AbTAFFFr>; Mon, 6 Jan 2003 00:05:47 -0500
Received: from h-64-105-35-112.SNVACAID.covad.net ([64.105.35.112]:16067 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S266367AbTAFFFp>; Mon, 6 Jan 2003 00:05:45 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 5 Jan 2003 21:14:09 -0800
Message-Id: <200301060514.VAA10937@adam.yggdrasil.com>
To: akpm@digeo.com
Subject: Re: Patch(2.5.54): devfs shrink - integration candidate
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton caught writes:
>That diff removes fs/namei.c.

	Grr.  Thanks for catching that.  I obviously botched the diff.
I've removed the old patch.  Here is a corrected version:

ftp://ftp.yggdrasil.com/pub/dist/device_control/devfs/smalldevfs-2.5.54-v7.patch
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
