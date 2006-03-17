Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbWCQLVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWCQLVW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 06:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbWCQLVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 06:21:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62370 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932074AbWCQLVV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 06:21:21 -0500
Date: Fri, 17 Mar 2006 03:18:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Bret Towe" <magnade@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nfs udp 1000/100baseT issue
Message-Id: <20060317031834.43d3c1e6.akpm@osdl.org>
In-Reply-To: <dda83e780603151424u1b3ea605vd6e8dea896fc276e@mail.gmail.com>
References: <dda83e780603151424u1b3ea605vd6e8dea896fc276e@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bret Towe" <magnade@gmail.com> wrote:
>
> ive seen this on kernels as far back as 2.6.13 on my own machines
>  (was around that time when i accutally got gigabit at home)
>  and recently noticed on some thin clients i maintain that 2.4 kernels
>  on the client side are also affected so perhaps its server side issue?
>  as all servers ive seen this on are 2.6 i havent used 2.4 kernels in ages
>  on my own machines so i havent looked into if 2.4 has that issue server side
>  or not

It would be interesting if you could do so.  I do recall that
nfs-over-crappy-udp was much better behaved in 2.4...

