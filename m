Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030239AbVKPI4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030239AbVKPI4T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 03:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbVKPI4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 03:56:19 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:56507 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030239AbVKPI4T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 03:56:19 -0500
Date: Wed, 16 Nov 2005 09:56:05 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@redhat.com>, kernel list <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: [linux-pm] [RFC] userland swsusp
Message-ID: <20051116085605.GE10143@elf.ucw.cz>
References: <20051115212942.GA9828@elf.ucw.cz> <20051115222549.GF17023@redhat.com> <20051115233201.GA10143@elf.ucw.cz> <20051115234007.GO17023@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051115234007.GO17023@redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > > Even it were not for this, the whole idea seems misconcieved to me
>  > > anyway.
>  > 
>  > ...but how do you provide nice, graphical progress bar for swsusp
>  > without this? People want that, and "esc to abort", compression,
>  > encryption. Too much to be done in kernel space, IMNSHO.
>  
> I'll take "rootkit doesnt work" over "bells and whistles".

It moves bunch of code from kernelspace to userspace. You don't have
to add bells and whistles at the same time. That's normally called
good thing. If Fedora has special needs, fine.
								Pavel
-- 
Thanks, Sharp!
