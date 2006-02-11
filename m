Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbWBKUTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbWBKUTr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 15:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWBKUTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 15:19:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52434 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932353AbWBKUTq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 15:19:46 -0500
Date: Sat, 11 Feb 2006 15:19:40 -0500
From: Dave Jones <davej@redhat.com>
To: Xose Vazquez Perez <xose.vazquez@gmail.com>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: old patches in -mm
Message-ID: <20060211201940.GC8337@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Xose Vazquez Perez <xose.vazquez@gmail.com>, akpm@osdl.org,
	torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <43EE415F.2000805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43EE415F.2000805@gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2006 at 08:56:15PM +0100, Xose Vazquez Perez wrote:
 > hi,
 > 
 > There are 35 patches(not included reiser4 and post-halloween-doc) older
 > than 2 months that still are not in mainline. Forgotten or experimental ?

Unless someone really cares about it, post-halloween-doc could be dropped.
It's way out of date in parts, and I don't think anyone really reads it.
It made a lot more sense when people were putting 2.6 kernels on
distros with old userspace. 

 > nvidia-agp-use-time_before_eq.patch

I've been slack with this, and as it wasn't urgent, I've queued it
for 2.6.17

		Dave
