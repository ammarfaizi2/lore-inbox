Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161028AbWBNMQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161028AbWBNMQk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 07:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161029AbWBNMQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 07:16:40 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:44605 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S1161028AbWBNMQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 07:16:39 -0500
Date: Tue, 14 Feb 2006 13:16:42 +0100
From: Sander <sander@humilis.net>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       sam@ravnborg.org
Subject: Re: 2.6.16-rc3-mm1
Message-ID: <20060214121642.GA23915@favonius>
Reply-To: sander@humilis.net
References: <20060214014157.59af972f.akpm@osdl.org> <6bffcb0e0602140316sae62b9an@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bffcb0e0602140316sae62b9an@mail.gmail.com>
X-Uptime: 12:53:22 up 14 days,  4:04, 24 users,  load average: 3.02, 2.81, 2.65
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Piotrowski wrote (ao):
> It's strange... rc3-mm1 vs. rc2-mm1
> 
> :/usr/src/linux-mm$ uname -a
> Linux ltg01-sid 2.6.16-rc2-mm1 #15 SMP PREEMPT Thu Feb 9 18:12:08 CET
> 2006 i686 GNU/Linux
> 
> 
> :/usr/src/linux-mm$ head Makefile
> VERSION = 2
> PATCHLEVEL = 6
> SUBLEVEL = 16
> EXTRAVERSION =-rc3-mm1
> 
> there is something wrong with build system.

You just booted an old kernel (see the date in your uname output).

	Kind regards, Sander

-- 
Humilis IT Services and Solutions
http://www.humilis.net
