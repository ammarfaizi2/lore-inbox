Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318007AbSHQSXQ>; Sat, 17 Aug 2002 14:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318064AbSHQSXQ>; Sat, 17 Aug 2002 14:23:16 -0400
Received: from mail.zmailer.org ([62.240.94.4]:50105 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S318007AbSHQSXQ>;
	Sat, 17 Aug 2002 14:23:16 -0400
Date: Sat, 17 Aug 2002 21:27:15 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Dax Kelson <dax@gurulabs.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Does Solaris really scale this well?
Message-ID: <20020817182715.GC32427@mea-ext.zmailer.org>
References: <Pine.LNX.4.10.10208171034330.23171-100000@master.linux-ide.org> <Pine.LNX.4.44.0208171151190.4792-100000@mooru.gurulabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208171151190.4792-100000@mooru.gurulabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2002 at 11:53:16AM -0600, Dax Kelson wrote:
> From:
>   http://www.itworld.com/Man/3828/020816mcnealy/
> 
> Scott McNealy:
> 
> "When you take a 99-way UltraSPARC III machine and add a 100th processor, 
> you get 94 percent linear scalability. You can't get 94 percent linear 
> scalability on your first Intel chip. It's very, very hard to do, and they 
> have not done it."

  Conditionally...  I would like to know the exact architecture,
and the problem set running in the system to say.

When you have noncc-NUMA, you have a Beowulf-like setup.
when you have cc-NUMA ("cc" = cache coherent), things get
truly hairy...
