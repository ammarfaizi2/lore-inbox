Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266478AbSL2GUM>; Sun, 29 Dec 2002 01:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266480AbSL2GUM>; Sun, 29 Dec 2002 01:20:12 -0500
Received: from dp.samba.org ([66.70.73.150]:37789 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266478AbSL2GUL>;
	Sun, 29 Dec 2002 01:20:11 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Frank Davis <fdavis@si.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.53 : modules_install warnings 
In-reply-to: Your message of "Sat, 28 Dec 2002 18:01:55 CDT."
             <Pine.LNX.4.44.0212281758230.839-100000@linux-dev> 
Date: Sun, 29 Dec 2002 17:09:51 +1100
Message-Id: <20021229062833.09C3F2C07F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0212281758230.839-100000@linux-dev> you write:
> Hello all,
>   I received the following warnings while a 'make modules_install'. It 
> looks like there are a few more locking changes that need to be made. :)

This is SMP, right?  Those warnings are perfectly correct (yes, those
files need updating).

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
