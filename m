Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262076AbTCUVVC>; Fri, 21 Mar 2003 16:21:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261966AbTCUVTp>; Fri, 21 Mar 2003 16:19:45 -0500
Received: from h-64-105-35-91.SNVACAID.covad.net ([64.105.35.91]:62656 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S261914AbTCUVT0>; Fri, 21 Mar 2003 16:19:26 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 21 Mar 2003 13:30:23 -0800
Message-Id: <200303212130.NAA07922@adam.yggdrasil.com>
To: hch@infradead.org
Subject: Re: small devfs patch for 2.5.65, plan to replace /sbin/hotplug
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Mar 2003, Christoph Hellwig wrote:
> - this patch doesn't include notify.c :)

	Arg!  OK, please try:

ftp://ftp.yggdrasil.com/pub/dist/device_control/devfs/smalldevfs-2.5.65-v14.patch

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
