Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751636AbWCUNWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636AbWCUNWY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 08:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751673AbWCUNWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 08:22:24 -0500
Received: from odin2.bull.net ([192.90.70.84]:27293 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S1750901AbWCUNWX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 08:22:23 -0500
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.16-rt1
Date: Tue, 21 Mar 2006 14:30:29 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <20060320085137.GA29554@elte.hu>
In-Reply-To: <20060320085137.GA29554@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603211430.29466.Serge.Noiraud@bull.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lundi 20 Mars 2006 09:51, Ingo Molnar wrote/a écrit :
> i have released the 2.6.16-rt1 tree, which can be downloaded from the 
> usual place:
> 
>    http://redhat.com/~mingo/realtime-preempt/
> 
> this is mostly a merge from -rc6 to 2.6.16-final, plus some smaller 
> fixes.

I get the following error :
...
Kernel: arch/i386/boot/bzImage is ready  (#2)
  Building modules, stage 2.
  MODPOST
*** Warning: "mutex_destroy" [fs/xfs/xfs.ko] undefined!
*** Warning: "there_is_no_init_MUTEX_LOCKED_for_RT_semaphores" [fs/xfs/xfs.ko] undefined!
...
Is it a BUG ?

-- 
Serge Noiraud
