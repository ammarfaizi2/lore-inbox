Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbWFHKfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWFHKfn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 06:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWFHKfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 06:35:43 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:41144 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932219AbWFHKfn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 06:35:43 -0400
Date: Thu, 8 Jun 2006 12:35:15 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Mark v Wolher <trilight@ns666.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.6.16.17 and 2.6.16.20 high cpuload (90-100 %)
In-Reply-To: <4487745C.8030000@ns666.com>
Message-ID: <Pine.LNX.4.61.0606081234090.19327@yvahk01.tjqt.qr>
References: <4487745C.8030000@ns666.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Any one noticed a problem with sis chipsets and the above kernels
>causing a high cpuload ? Every processes executed or pressing enter to
>refresh top causes a huge cpu spike usually to 100 %.

What sort of cpuload? User, system, iowait, etc?
Do the vales in /proc/interrupts increment "faster than normal"?

>The debian sarge distro kernel 2.4.27 works flawlessly.
>Appreciate a few hints/advise i can check before diving into deeper waters.

Jan Engelhardt
-- 
