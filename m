Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269650AbUICMEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269650AbUICMEQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 08:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269643AbUICMEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 08:04:15 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:40167 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S269649AbUICMD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 08:03:58 -0400
Date: Fri, 3 Sep 2004 08:08:19 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc1-mm3
In-Reply-To: <20040903014811.6247d47d.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0409030803090.4481@montezuma.fsmlabs.com>
References: <20040903014811.6247d47d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Sep 2004, Andrew Morton wrote:

>   - i386 hotplug CPU support: I'm not sure that we should merge this at
>     all - it's a testing-only thing.

swsusp will be the in kernel user, it's next on my todo list (i just need
to coerce my hardware to play along). But of course, code talks...

> -completely-out-of-line-spinlocks--generic.patch
> -completely-out-of-line-spinlocks--i386.patch
> -completely-out-of-line-spinlocks--x86_64.patch
>
>  Dropped - out of date.

Saved me requesting it get dropped =)

Thanks,
	Zwane
