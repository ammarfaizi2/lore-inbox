Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbWHUVYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWHUVYX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 17:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWHUVYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 17:24:22 -0400
Received: from ns2.suse.de ([195.135.220.15]:37336 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751147AbWHUVYI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 17:24:08 -0400
Date: Mon, 21 Aug 2006 23:24:04 +0200
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Jan Beulich <jbeulich@novell.com>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: 2.6.18-rc4-mm2: x86_64 compile error
Message-Id: <20060821232404.4e6a83b2.ak@suse.de>
In-Reply-To: <20060821212140.GN11651@stusta.de>
References: <20060819220008.843d2f64.akpm@osdl.org>
	<20060821212140.GN11651@stusta.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2006 23:21:40 +0200
Adrian Bunk <bunk@stusta.de> wrote:

> On Sat, Aug 19, 2006 at 10:00:08PM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.18-rc4-mm1:
> >...
> > +x86_64-mm-fix-x86-cpuid-keys-used-in-alternative_smp.patch
> >...
> >  x86_64 tree updates
> >...
> 
> This patch causes the following compile error (cross compiling from i386 
> using gcc 4.1):

It should be already fixed in my tree

-Andi
