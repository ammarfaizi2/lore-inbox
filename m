Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317342AbSHGNGf>; Wed, 7 Aug 2002 09:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317338AbSHGNGe>; Wed, 7 Aug 2002 09:06:34 -0400
Received: from zeus.kernel.org ([204.152.189.113]:47243 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S317115AbSHGNGc>;
	Wed, 7 Aug 2002 09:06:32 -0400
Date: Wed, 7 Aug 2002 14:31:25 +0200
From: Stephane Wirtel <stephane.wirtel@belgacom.net>
To: hahn@physics.mcmaster.ca;riel@conectiva.com.br;;;;
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG at page_alloc.c:113!
Message-Id: <20020807143125.30802c58.stephane.wirtel@belgacom.net>
In-Reply-To: <Pine.LNX.4.33.0208062317220.21983-100000@coffee.psychology.mcmaster.ca>
References: <20020807034831.2fa1823f.stephane.wirtel@belgacom.net>
	<Pine.LNX.4.33.0208062317220.21983-100000@coffee.psychology.mcmaster.ca>
X-Mailer: Sylpheed version 0.8.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > the bug is in linux/mm/page_alloc at line 113
> 
> can you replicate without the tainting (NV) module?
> 
> 

without this module, i don't have this problem.

certainly an error of Nvidia developpers.


thanks you

