Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265016AbUETJXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265016AbUETJXv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 05:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265038AbUETJXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 05:23:51 -0400
Received: from dirac.phys.uwm.edu ([129.89.57.19]:30850 "EHLO
	dirac.phys.uwm.edu") by vger.kernel.org with ESMTP id S265016AbUETJXs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 05:23:48 -0400
Date: Thu, 20 May 2004 04:23:43 -0500 (CDT)
From: Bruce Allen <ballen@gravity.phys.uwm.edu>
To: Sebastian <sebastian@expires0604.datenknoten.de>
cc: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>,
       linux-kernel@vger.kernel.org
Subject: Re: Strange DMA-errors and system hang with Promise 20268
In-Reply-To: <1084990345.4371.5.camel@coruscant.datenknoten.de>
Message-ID: <Pine.GSO.4.21.0405200422280.24137-100000@dirac.phys.uwm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hhmm. I have not changed anything major on that machine except the
> Kernel for years. Only after upgrading from 2.4.23 to 2.4.25, I got
> these problems. 
> If there is no problem with the kernel, I have to assume a hardware
> failure of some kind. Badblocks/smartlog reveal no errors.

Sebastian, does the disk's SMART error log (smartctl -l error) give any
indication of what's wrong?

Bruce

