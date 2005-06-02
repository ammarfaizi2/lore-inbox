Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbVFBBvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbVFBBvj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 21:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbVFBBvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 21:51:37 -0400
Received: from fsmlabs.com ([168.103.115.128]:18062 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261567AbVFBBvF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 21:51:05 -0400
Date: Wed, 1 Jun 2005 19:54:34 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Tony Lindgren <tony@atomide.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Dynamic tick for x86 version 050602-1
In-Reply-To: <20050602013641.GL21597@atomide.com>
Message-ID: <Pine.LNX.4.61.0506011953090.22613@montezuma.fsmlabs.com>
References: <20050602013641.GL21597@atomide.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On Wed, 1 Jun 2005, Tony Lindgren wrote:

> Here's an updated version of the dynamic tick patch.
> 
> It's mostly clean-up and it's now using the standard
> monotonic_clock() functions as suggested by John Stultz.
> 
> Please let me know of any issues with the patch. I'll continue to do
> more clean-up on it, but I think the basic functionality is done.
> 
> Thomas, where do you have the latest version of your ACPI idle
> patch? I'd like to add that to the dyn-tick page as well.
> 
> Older patches and some related links are at:
> 
> http://muru.com/linux/dyntick/

Are there any 'known issues' wrt various timer sources with this version?

Thanks,
	Zwane

