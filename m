Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269330AbUJKV4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269330AbUJKV4H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 17:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269280AbUJKV4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 17:56:06 -0400
Received: from cantor.suse.de ([195.135.220.2]:32141 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269301AbUJKVw7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 17:52:59 -0400
Date: Mon, 11 Oct 2004 23:52:58 +0200
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4-mm1
Message-ID: <20041011215258.GC5461@wotan.suse.de>
References: <20041011032502.299dc88d.akpm@osdl.org> <Pine.LNX.4.61.0410111844450.2873@musoma.fsmlabs.com> <20041011125507.3d733256.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041011125507.3d733256.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > allow-x86_64-to-reenable-interrupts-on-contention.patch
> >   Allow x86_64 to reenable interrupts on contention
> 
> IIRC Andi made skeptical noises about this one.

With the out of line spinlocks there is no reason to not apply
it anymore. But I'm still not sure if it actually helps for anything ...

-Andi
