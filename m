Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317152AbSGCSxh>; Wed, 3 Jul 2002 14:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317165AbSGCSxg>; Wed, 3 Jul 2002 14:53:36 -0400
Received: from www.transvirtual.com ([206.14.214.140]:49933 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S317152AbSGCSxg>; Wed, 3 Jul 2002 14:53:36 -0400
Date: Wed, 3 Jul 2002 11:55:53 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Dave Jones <davej@suse.de>
cc: Skip Ford <skip.ford@verizon.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [PATCH] New Console system BK
In-Reply-To: <20020703173822.C8934@suse.de>
Message-ID: <Pine.LNX.4.44.0207031155190.16404-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  > Without the patch, I can hold down alt and hit F1, F2, F3, F4, then
>  > release the alt key and I will have switched to each of the VTs.
>  > With this patch, I have to press/release alt for each Fx key.
>
> Strange, that's a reoccurance of a bug that happened many moons ago
> circa 2.5.4-dj or so, which James then subsequently fixed. Seems he
> dropped a bugfix or two..

Ah. I was using the old patches. I will have to find the fix and put it
into the keyboard driver.

