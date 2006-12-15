Return-Path: <linux-kernel-owner+w=401wt.eu-S1753456AbWLOWBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456AbWLOWBT (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 17:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753524AbWLOWBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 17:01:19 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:42753 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753456AbWLOWBS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 17:01:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=EYd23xH7NHpDsgeMQCcq7XkQwvrqaLqVkGz+ssfBjoBEugsaG0ZlIJRM6w/RcNIqztB5hqMdazccrmQ1gziBDpmmhafOMGXm9e3Q71h6ldrFpM/ku41wd6XUYeB7lFcoxdtLBIAzUfdZIueV9Alhd+kkh2hgsav3l0XXMCzgvHg=
Date: Sat, 16 Dec 2006 01:01:17 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: James Porter <jameslporter@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Binary Drivers
Message-ID: <20061215220117.GA24819@martell.zuzino.mipt.ru>
References: <loom.20061215T220806-362@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <loom.20061215T220806-362@post.gmane.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 15, 2006 at 09:20:58PM +0000, James Porter wrote:
> I think some kernel developers take to much responsibility, is there a bug in a
> binary driver? Send it upstream and explain to the user that it's a closed
> source driver and is up to said company to fix it.
>
> For what it's worth, I don't see any problem with binary drivers from hardware
> manufacturers.

Binary drivers from hardware manufacturers are crap. Learn it by heart.

> Just because nvidia makes a closed source driver doesn't mean that we can't also
> create an open source driver(limited functionality, reverse engineered,
> etc.,etc.).

We can.

> I firmly believe that the choice should be up to the user and/or
> distro. I'm not a kernel dev, I don't know c...

but you can't.

> but I understand the concepts and
> I should have the right to do what I want with this GPL code.

You don't have a right to do what you want with GNU GPL'ed code.
Read the fucking license, already.

> Restricting me only frustrates me.

Nobody is restricting you.

> Should the default be open source, definitely; should binary
> drivers be blocked from running on a linux kernel...certainly not.

But users of binary drivers should be blocked from sending bug reports
to kernel developers.

> I personally like nvidia's products, they have spent a lot of money in R&D. One
> example is SLI, if their spec was open what would stop ATI from stealing their
> work(patents?, gotta love those).

I lost a nice quote about 10-20% of the community stopping making
excuses for vendors. Sad, sad, nice quote definitely.

> Personally I think nvidia has excellent
> support for linux, I have actually convinced people to use linux(desktop and
> server) just by showing them beryl with the nvidia beta drivers.

beryl on server?

> Lastly I think it's ridiculous to create,diplay, and distribute "Free" as in
> freedom and "Free" as in cost software only to later consider limiting my
> freedom...

Nobody is limiting you.

> want to know why a lot of large companies don't support
> linux...exactly threads like this.

You asked them?

> Why make the effort to use "Free" software
> only to have the rug pulled out from under you. This is what makes the BSDs so
> attractive.

So use BSD.

