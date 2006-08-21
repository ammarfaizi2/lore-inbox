Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbWHUTJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWHUTJZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 15:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWHUTJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 15:09:25 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:33927
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750778AbWHUTJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 15:09:24 -0400
Date: Mon, 21 Aug 2006 12:09:38 -0700 (PDT)
Message-Id: <20060821.120938.74556467.davem@davemloft.net>
To: johnpol@2ka.mipt.ru
Cc: bernd@firmix.at, hch@infradead.org, linux-kernel@vger.kernel.org,
       drepper@redhat.com, akpm@osdl.org, netdev@vger.kernel.org,
       zach.brown@oracle.com
Subject: Re: [take9 1/2] kevent: Core files.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060821130121.GA2602@2ka.mipt.ru>
References: <20060821111335.GA8608@2ka.mipt.ru>
	<1156164805.17936.132.camel@tara.firmix.at>
	<20060821130121.GA2602@2ka.mipt.ru>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Date: Mon, 21 Aug 2006 17:01:21 +0400

> Actually I completely do not care about define or enums, it is really
> silly dispute, I just do not want to rewrite bunch of code _again_ and
> then _again_ when someone decide that defines are better.

I totally agree.

What in the world is wrong with you people arguing over stuff like
this?

If the goal is to discourage Evgeniy and his work, you might just
get your wish if you keep up with this silly coding style and
enumeration crap!

I can't even stand to read these kevent threads any longer, the
sanity in them has long gone out the window.
