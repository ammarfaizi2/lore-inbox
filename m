Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbVHOPdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbVHOPdY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 11:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbVHOPdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 11:33:24 -0400
Received: from fsmlabs.com ([168.103.115.128]:12478 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S964792AbVHOPdY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 11:33:24 -0400
Date: Mon, 15 Aug 2005 09:39:15 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Con Kolivas <kernel@kolivas.org>
cc: Pavel Machek <pavel@suse.cz>, Jim MacBaine <jmacbaine@gmail.com>,
       linux-kernel@vger.kernel.org, ck@vds.kolivas.org, tony@atomide.com,
       tuukka.tikkanen@elektrobit.com
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 3
In-Reply-To: <200508152252.47825.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.61.0508150938460.13333@montezuma.fsmlabs.com>
References: <200508031559.24704.kernel@kolivas.org> <20050814194756.GC1686@openzaurus.ucw.cz>
 <Pine.LNX.4.61.0508141942480.6740@montezuma.fsmlabs.com>
 <200508152252.47825.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Aug 2005, Con Kolivas wrote:

> > Why not just set it to a fixed frequency, suspend and then on boot resume
> > to a fixed frequency and let the timer tick code eventually switch back.
> 
> It's probably worth holding off further discussion on this point till the SMP 
> scalable version is working well enough and see if/how the problem manifests 
> there.

For suspend it'll manifest in the same way.

	Zwane

