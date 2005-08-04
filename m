Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262687AbVHDUv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbVHDUv7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 16:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbVHDUto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 16:49:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43143 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262670AbVHDUs0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 16:48:26 -0400
Date: Thu, 4 Aug 2005 13:49:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: teanropo@cc.jyu.fi, ink@jurassic.park.msu.ru, gregkh@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc2 hangs at boot
Message-Id: <20050804134952.7ca73e00.akpm@osdl.org>
In-Reply-To: <9e47339105070618273dfb6ff8@mail.gmail.com>
References: <Pine.GSO.4.58.0507061638380.13297@tukki.cc.jyu.fi>
	<9e47339105070618273dfb6ff8@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl <jonsmirl@gmail.com> wrote:
>
> I'm dead on a Dell PE400SC without reverting this.
> 
> On 7/6/05, Tero Roponen <teanropo@cc.jyu.fi> wrote:
> > Hi,
> > 
> > my computer (a ThinkPad 380XD laptop) hangs at boot in 2.6.13-rc2.
> > When I revert the patch below everything seems to be fine.
> > 
> > thanks,
> > Tero Roponen
> > 
> > 
> > Patch to revert:
> > 
> > Author: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> > Date: Wed, 15 Jun 2005 14:59:27 +0000 (+0400)
> > Source: http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=299de0343c7d18448a69c635378342e9214b14af

Guys, I'm going to assume that all these problems are fixed in 2.6.13-rc6
due to various fixes and reversions.

If that's not correct then please raise new reports, preferably at
bugzilla.kernel.org, thanks.

