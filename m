Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263593AbUD3RrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263593AbUD3RrG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 13:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265159AbUD3RrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 13:47:05 -0400
Received: from fep02-mail.bloor.is.net.cable.rogers.com ([66.185.86.72]:34728
	"EHLO fep02-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S263593AbUD3RrB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 13:47:01 -0400
Date: Fri, 30 Apr 2004 13:46:53 -0400
From: Sean Estabrooks <seanlkml@rogers.com>
To: Marc Boucher <marc@linuxant.com>
Cc: miller@techsource.com, koke@sindominio.net, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, riel@redhat.com,
       david@gibson.dropbear.id.au, paul@wagland.net
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Message-Id: <20040430134653.4f11c843.seanlkml@rogers.com>
In-Reply-To: <E17E7EB8-9AC9-11D8-B83D-000A95BCAC26@linuxant.com>
References: <Pine.LNX.4.44.0404291114150.9152-100000@chimarrao.boston.redhat.com>
	<4FE43C97-9A20-11D8-B804-000A95CD704C@wagland.net>
	<4091757B.3090209@techsource.com>
	<200404292347.17431.koke_lkml@amedias.org>
	<0CAE0144-9A2C-11D8-B83D-000A95BCAC26@linuxant.com>
	<20040429195553.4fba0da7.seanlkml@rogers.com>
	<4092776A.5020705@techsource.com>
	<E17E7EB8-9AC9-11D8-B83D-000A95BCAC26@linuxant.com>
Organization: 
X-Mailer: Sylpheed version 0.9.9-gtk2-20040229 (GTK+ 2.2.4; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep02-mail.bloor.is.net.cable.rogers.com from [24.103.219.176] using ID <seanlkml@rogers.com> at Fri, 30 Apr 2004 13:46:07 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Apr 2004 13:14:46 -0400
Marc Boucher <marc@linuxant.com> wrote:

> <snip>
> Sure, but it is imho generally better to maintain reasonable balance 
> and serve the "common good" rather than specific political interests. 
> However that is purely personal opinion and everyone is free to 
> choose/practice their political ideals, preferably without stepping 
> onto others.
 
Would you please drop this notion that this is somehow political.   People
who are just as intelligent as you have looked at the facts and concluded
that your actions hurt Linux in a practical way.   That's not a political
idea that's practical idea.    Others are just concerned about support
issues.  The point is you opinion isn't  more important.

You cast everyone who has come to a different conclusion than you as a
political or religious zealot.   This is just a way for you to demean
these people and not deal with their honest concerns and admit there's a
chance you're wrong. If you feel very strongly about going against the
wishes of the kernel maintainers I suggest you fork the kernel and do
whatever you want.

But since even  you say you would rather see open source drivers over
proprietary how about asking for this warning:

"Now loading a non GPL driver.   Please consider supporting vendors that
provide open source drivers for their hardware.  Your kernel will now be
marked as tainted, all this means is that you should send any support
requests to the author of this driver."

That should remove any confusion and also show respect Linux and its
license.

Regards,
Sean
