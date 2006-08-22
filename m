Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbWHVPTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbWHVPTd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 11:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbWHVPTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 11:19:33 -0400
Received: from rubidium.solidboot.com ([81.22.244.175]:59071 "EHLO
	mail.solidboot.com") by vger.kernel.org with ESMTP id S932143AbWHVPTc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 11:19:32 -0400
Message-ID: <44EB2083.8080902@solidboot.com>
Date: Tue, 22 Aug 2006 18:19:31 +0300
From: Juha Yrjola <juha.yrjola@solidboot.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Daniel Drake <dan@reactivated.net>, Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Matt Reimer <mattjreimer@gmail.com>, linux-kernel@vger.kernel.org,
       rmk+lkml@arm.linux.org.uk
Subject: Re: 2GB MMC/SD cards
References: <447AFE7A.3070401@drzeus.cx> <20060603141548.GA31182@flint.arm.linux.org.uk> <f383264b0606031140l2051a2d7p6a9b2890a6063aef@mail.gmail.com> <4481FB80.40709@drzeus.cx> <4484B5AE.8060404@drzeus.cx> <44869794.9080906@drzeus.cx> <20060607165837.GE13165@flint.arm.linux.org.uk> <448738CD.8030907@drzeus.cx> <4488AC57.7050201@drzeus.cx> <44DEFBA1.6060500@reactivated.net>
In-Reply-To: <44DEFBA1.6060500@reactivated.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Drake wrote:
> Hi Pierre,
> 
> Pierre Ossman wrote:
>> Suggested patch included.
> 
> What's the status on this patch? A Gentoo user at 
> http://bugs.gentoo.org/142172 reports that it is required for him to be 
> able to access his card, so it definitely works in some form.

I have to pitch in here.  This patch is required for some cards to 
operate reliably on the Nokia 770, and we've done quite a bit of 
interoperability testing already.

Pierre, could you submit it to RMK's patch tracking system?

Cheers,
Juha
