Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270835AbTHARyP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 13:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270845AbTHARyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 13:54:15 -0400
Received: from bay7-f15.bay7.hotmail.com ([64.4.11.15]:19717 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S270835AbTHARyO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 13:54:14 -0400
X-Originating-IP: [62.98.206.48]
X-Originating-Email: [kernel_286@hotmail.com]
From: "jorge kernel" <kernel_286@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: VFS: Cannot open root device "304" or hda4
Date: Fri, 01 Aug 2003 19:54:13 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Message-ID: <BAY7-F15n2AI3F5Y0Zw00011242@hotmail.com>
X-OriginalArrivalTime: 01 Aug 2003 17:54:13.0376 (UTC) FILETIME=[EAF2F000:01C35855]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Burton Windle <bwindle@fint.org>
>To: kernel_286@hotmail.com
>Subject: Re: VFS: Cannot open root device "304" or hda4
>Date: Fri, 1 Aug 2003 11:36:01 -0400 (EDT)

Hi Burton,

>Are you sure that you compiled in support for your IDE controller and file
>system type?

Mmm..
My hardware config consists in an Acer 272Xv with sis chipset 650 (I read it 
in 2.4.21 and previous dmesg).
I think that config file is OK because when 2.6 starts, I can see something 
about "SIS961 chipset MUTIOL", and in the .config file I've set 
CONFIG_BLK_DEV_SIS5513=y that I always used for previous kernels.

						Mario
>
>--
>Burton Windle                           burton@fint.org
>Linux: the "grim reaper of innocent orphaned children."
>           from /usr/src/linux-2.4.18/init/main.c:461
>

_________________________________________________________________
Nuovo MSN Messenger 6.0 con sfondi e giochi! http://messenger.msn.it/ 
Provalo subito!

