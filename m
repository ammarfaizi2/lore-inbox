Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266870AbUIOCmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266870AbUIOCmL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 22:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266891AbUIOCmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 22:42:00 -0400
Received: from fire.osdl.org ([65.172.181.4]:37560 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S266870AbUIOClg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 22:41:36 -0400
Message-ID: <1109.4.5.49.23.1095216021.squirrel@www.osdl.org>
In-Reply-To: <Pine.LNX.4.61.0409150255590.981@scrub.home>
References: <41476413.1060100@linux-user.net>
    <Pine.LNX.4.61.0409150255590.981@scrub.home>
Date: Tue, 14 Sep 2004 19:40:21 -0700 (PDT)
Subject: Re: [PATCH] README (resend) - Explain new 2.6.xx.x version number
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Roman Zippel" <zippel@linux-m68k.org>
Cc: "Daniel Andersen" <anddan@linux-user.net>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
User-Agent: SquirrelMail/1.4.2-1_osdl_00
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
>
> On Tue, 14 Sep 2004, Daniel Andersen wrote:
>
>> This one ended up in the void last time without any comments.
>
> The funny thing is by the time people managed to apply the patch
> correctly, they don't need to read the README anymore.

That's correct for this time.  However, if they have other kernel
trees (in the future) with this patch applied, it can help.

> Seriously, without knowing about the pre-patches, what would you expect
> about the patch order if you found the patches 2.6.8, 2.6.8.1, 2.6.9?

We have evidence that it's confusing to more than one person.

~Randy

