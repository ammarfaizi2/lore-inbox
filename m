Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbUKSIvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbUKSIvl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 03:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbUKSIvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 03:51:40 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:50128 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261308AbUKSIvd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 03:51:33 -0500
Date: Fri, 19 Nov 2004 09:51:32 +0100
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: ak@suse.de, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: let x86_64 no longer define X86
Message-ID: <20041119085132.GB26231@wotan.suse.de>
References: <20041119005117.GM4943@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041119005117.GM4943@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2004 at 01:51:17AM +0100, Adrian Bunk wrote:
> I'd like to send a patch after 2.6.10 that removes the following from 
> arch/x86_64/Kconfig:
> 
>   config X86
>         bool
>         default y

I'm against this. Please don't do this.

-Andi
