Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbVGFSiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbVGFSiu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 14:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbVGFSiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 14:38:50 -0400
Received: from fsmlabs.com ([168.103.115.128]:38068 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261520AbVGFNft (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 09:35:49 -0400
Date: Wed, 6 Jul 2005 07:40:32 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Nigel Cunningham <ncunningham@cyclades.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [19/48] Suspend2 2.1.9.8 for 2.6.12: 510-version-specific-mac.patch
In-Reply-To: <1120622393.4860.22.camel@localhost>
Message-ID: <Pine.LNX.4.61.0507060739110.2149@montezuma.fsmlabs.com>
References: <11206164411926@foobar.com>  <Pine.LNX.4.61.0507052145470.2149@montezuma.fsmlabs.com>
 <1120622393.4860.22.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2005, Nigel Cunningham wrote:

> I've just noticed that all the subject lines are off by one. Sorry.
> Shall I repost with it right this time?

Yes the subject lines did look a bit confusing, it may be easier in future 
to add a short description of the patch instead of relying on the 
patch name.

> Regarding this x86_64 patch, I haven't been able to test x86_64 support
> yet (no hardware here), so I'm sure you're right about all the things.
> I've really just parroted what swsusp does in its lowlevel code, since
> saving and restoring cpu state is one thing we do the same way.
> 
> Will apply changes.

Fair enough.

Thanks,
	Zwane

