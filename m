Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262264AbVBKQNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262264AbVBKQNw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 11:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262266AbVBKQNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 11:13:52 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:34951 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262264AbVBKQNX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 11:13:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=jIH1rvuoByHuP7iNnyBBgTjzl8mTQE+76O9js4l1wlC1n8u3y9JnVjhb2+SwsXzIQcacRm7PYlPLuaykfgI4wmt9MeP/9vofuapI9BDJ7YEPYmLW+0Jt1KmmUXyNhcXpjNQnlKqFeaoNk4z6BAHAYliVjECFcan8RcMT2h4/YjA=
Message-ID: <9e473391050211081338f9d84e@mail.gmail.com>
Date: Fri, 11 Feb 2005 11:13:23 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Alexandre Oliva <aoliva@redhat.com>
Subject: Re: [RFC] Linux Kernel Subversion Howto
Cc: Larry McVoy <lm@bitmover.com>, Stelian Pop <stelian@popies.net>,
       Francois Romieu <romieu@fr.zoreil.com>, linux-kernel@vger.kernel.org
In-Reply-To: <or1xbn6rn5.fsf@livre.redhat.lsd.ic.unicamp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050204201157.GN27707@bitmover.com>
	 <20050205193848.GH5028@deep-space-9.dsnet>
	 <20050205233841.GA20875@bitmover.com>
	 <20050208154343.GH3537@crusoe.alcove-fr>
	 <20050208155845.GB14505@bitmover.com>
	 <ord5vatdph.fsf@livre.redhat.lsd.ic.unicamp.br>
	 <20050209155113.GA10659@bitmover.com>
	 <or7jlgpxio.fsf@livre.redhat.lsd.ic.unicamp.br>
	 <20050210211700.GA26361@bitmover.com>
	 <or1xbn6rn5.fsf@livre.redhat.lsd.ic.unicamp.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Feb 2005 07:39:47 -0800 (PST), Alexandre Oliva
<aoliva@redhat.com> wrote:
> The bit I don't understand is that you've claimed you'd be willing to
> implement the code needed to export the additional information that
> Roman, myself and probably many others would like to have, if someone
> would pay for that, but you're not willing to grant him access to this
> information such that he can write the code himself.  How come you
> wouldn't welcome a BK-export piece of software that you could use
> yourself to create and maintain the CVS tree, without having to
> develop and maintain the software, and insist on developing such
> software yourself, but only if someone else pays for it?

Think about it from Larry's side for a minute. BK is a proprietary
piece of software, it is not open source.  That means that anyone who
works on it needs to be an employee or contractor of Bitmover and have
signed all of the appropriate non-disclosure and non-compete
documents.  These documents exist at all proprietary software
companies, they are not specific to Bitmover. None of you guys are
willing to sign those documents.

It's not Larry choosing not to have you do the work, you are self
selecting not to do it because you won't sign the contracts. Larry
also has to be reasonably confident that if you do sign you won't
violate them.

The conclusion is that someone else who is willing to sign the
documents has to do the work. That person needs to be hired and paid.
It is unreasonable to ask Larry to add features like you want on his
own dime.

There is a solution on the table:
1) Written proposal describing in detail the commands you want added to bk
2) Submit it for a quote.
3) Raise the money 
4) Negotiate for exact delivery dates.

Since no one has bothered to put together a real proposal, I can only
conclude that you are more interested in writing email complaints than
actually achieving a solution.

-- 
Jon Smirl
jonsmirl@gmail.com
