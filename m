Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbWETVGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbWETVGs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 17:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWETVGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 17:06:47 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:46052 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932305AbWETVGr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 17:06:47 -0400
Date: Sat, 20 May 2006 23:06:41 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andrew Morton <akpm@osdl.org>
cc: Evgeniy Dushistov <dushistov@mail.ru>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] ufs: directory and page cache: from blocks to pages
In-Reply-To: <20060519110821.7d033ee4.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0605202305400.27403@yvahk01.tjqt.qr>
References: <20060519171833.GA28572@rain.homenetwork> <20060519110821.7d033ee4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Does anyone know of a good way of creating UFS filesytems under Linux?  I
>had a go at porting BSD ufsutils a few years ago and nearly died.  There's
>http://ufs-linux.sourceforge.net/, but that hasn't been touched in a couple
>of years..
>
Have you tried emulating BSD (is that actually possible under Linux-x86?)

And not to forget: Solaris UFS. It's yet another matter in the ufs jungle.


Jan Engelhardt
-- 
