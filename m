Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967242AbWKYXCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967242AbWKYXCf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 18:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967243AbWKYXCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 18:02:35 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:40890
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S967242AbWKYXCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 18:02:34 -0500
Date: Sat, 25 Nov 2006 15:02:48 -0800 (PST)
Message-Id: <20061125.150248.62667065.davem@davemloft.net>
To: torvalds@osdl.org
Cc: samuel@sortiz.org, a.p.zijlstra@chello.nl,
       irda-users@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       mingo@elte.hu, arvidjaar@mail.ru, akpm@osdl.org
Subject: Re: [PATCH] Revert "[IRDA]: Lockdep fix."
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0611251324260.3483@woody.osdl.org>
References: <20061125152649.GA5698@sortiz.org>
	<20061125.130927.87744078.davem@davemloft.net>
	<Pine.LNX.4.64.0611251324260.3483@woody.osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@osdl.org>
Date: Sat, 25 Nov 2006 13:26:51 -0800 (PST)

> I now (finally) have the patch from Andrew, but we should _not_ have had 
> this thing broken for three days. It should have gotten reverted on the 
> first report of trouble, instead of us telling people to just wait.
> 
> Broken compiles are simply not acceptable. Patches that cause them should 
> be reverted _immediately_ unless a fix is available as quickly (which it 
> wasn't due to turkey-day).
> 
> No excuses. People _should_ be impatient about idiotic failures like this.

Ok, no problem.
