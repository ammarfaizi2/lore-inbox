Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262453AbVG2LLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbVG2LLz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 07:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262463AbVG2LLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 07:11:55 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:60617 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262453AbVG2LLo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 07:11:44 -0400
Date: Fri, 29 Jul 2005 13:11:38 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: antoine <antoine@nagafix.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel BUG at "mm/rmap.c":493 OR corrupt swap partition
In-Reply-To: <1122626872.4018.9.camel@dhcp-192-168-22-217.internal>
Message-ID: <Pine.LNX.4.61.0507291311050.10775@yvahk01.tjqt.qr>
References: <1122626872.4018.9.camel@dhcp-192-168-22-217.internal>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Date: Fri, 29 Jul 2005 09:47:52 +0100
>From: antoine <antoine@nagafix.co.uk>
>To: linux-kernel@vger.kernel.org
>Subject: Kernel BUG at "mm/rmap.c":493 OR corrupt swap partition

If the swap partition is corrupt, rerunning mkswap on it (while being turned 
off, of course) should at best fix it.


Jan Engelhardt
-- 
