Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263763AbTEFOwe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 10:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263777AbTEFOwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 10:52:34 -0400
Received: from h-64-105-35-101.SNVACAID.covad.net ([64.105.35.101]:56741 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP id S263763AbTEFOwd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 10:52:33 -0400
Date: Tue, 6 May 2003 08:04:15 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200305061504.h46F4FL19827@freya.yggdrasil.com>
To: linux-kernel@vger.kernel.org, simon@thekelleys.org.uk
Subject: Re: Binary firmware in the kernel - licensing issues.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Kelley wrote:
>Maybe this is the sort of thing I need:
>
>http://www.keyspan.com/support/linux/

	I believe that the keyspan drivers that compile GPL-incompatible
firmware into the kernel or kernel modules are illegal.  I tried
being a nice guy about it, to the point of wring a user level
firmware loader could be invoked automatically via hotplug:
http://marc.theaimsgroup.com/?l=linux-usb-devel&m=98758846106843&w=2.
You can look in the linux-usb-devel archives at about that time
for further discussion of the copyright issues.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Miplitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
