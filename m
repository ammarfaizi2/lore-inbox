Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965094AbWHWS2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965094AbWHWS2R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 14:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965095AbWHWS2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 14:28:17 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:25225 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S965094AbWHWS2R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 14:28:17 -0400
Message-ID: <44EC9E3E.4010502@drzeus.cx>
Date: Wed, 23 Aug 2006 20:28:14 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Juha Yrjola <juha.yrjola@solidboot.com>
CC: Daniel Drake <dan@reactivated.net>, Matt Reimer <mattjreimer@gmail.com>,
       linux-kernel@vger.kernel.org, rmk+lkml@arm.linux.org.uk
Subject: Re: 2GB MMC/SD cards
References: <447AFE7A.3070401@drzeus.cx> <20060603141548.GA31182@flint.arm.linux.org.uk> <f383264b0606031140l2051a2d7p6a9b2890a6063aef@mail.gmail.com> <4481FB80.40709@drzeus.cx> <4484B5AE.8060404@drzeus.cx> <44869794.9080906@drzeus.cx> <20060607165837.GE13165@flint.arm.linux.org.uk> <448738CD.8030907@drzeus.cx> <4488AC57.7050201@drzeus.cx> <44DEFBA1.6060500@reactivated.net> <44EB2083.8080902@solidboot.com>
In-Reply-To: <44EB2083.8080902@solidboot.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juha Yrjola wrote:
>
> I have to pitch in here.  This patch is required for some cards to
> operate reliably on the Nokia 770, and we've done quite a bit of
> interoperability testing already.
>
> Pierre, could you submit it to RMK's patch tracking system?
>

It's a bit up in the air at the moment, but my ambition is to have it in
before 2.6.18 is out.

Rgds
Pierre

