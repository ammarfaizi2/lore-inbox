Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269076AbUJKP54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269076AbUJKP54 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 11:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269048AbUJKPzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 11:55:17 -0400
Received: from cantor.suse.de ([195.135.220.2]:31158 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269127AbUJKPxx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 11:53:53 -0400
Date: Mon, 11 Oct 2004 17:49:34 +0200
From: Andi Kleen <ak@suse.de>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc4-mm1
Message-ID: <20041011154934.GD26350@wotan.suse.de>
References: <20041011032502.299dc88d.akpm@osdl.org> <Pine.LNX.4.61.0410111844450.2873@musoma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0410111844450.2873@musoma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2004 at 06:47:45PM +0300, Zwane Mwaikambo wrote:
> How about the following?
> 
> remove-lock_section-from-x86_64-spin_lock-asm.patch
>   remove LOCK_SECTION from x86_64 spin_lock asm
> 
> allow-x86_64-to-reenable-interrupts-on-contention.patch
>   Allow x86_64 to reenable interrupts on contention
> 
> The former is a fix.

What does it fix? 

-Andi
