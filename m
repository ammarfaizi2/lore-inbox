Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264734AbUFPUet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264734AbUFPUet (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 16:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264762AbUFPUes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 16:34:48 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:15237 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S264734AbUFPUe0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 16:34:26 -0400
Message-ID: <5b18a542040616133415bf54d1@mail.gmail.com>
Date: Wed, 16 Jun 2004 16:34:25 -0400
From: Erik Harrison <erikharrison@gmail.com>
To: davids@webmaster.com
Subject: Re: more files with licenses that aren't GPL-compatible
Cc: eric@cisu.net, Christoph Hellwig <hch@lst.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKEEFGMKAA.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <MDEHLPKNGKAHNMBLJOLKEEFGMKAA.davids@webmaster.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2004 21:11:00 -0700, David Schwartz <davids@webmaster.com> wrote:
> 
> 
> > >     Permission is hereby granted for the distribution of this firmware
> > >     image as part of a Linux or other Open Source operating
> > >   system kernel
> > >     in text or binary form as required.
> 
>        They can't grant that permission. Every single person who had contributed
> to the Linux kernel would have to agree. The GPL prohibits including
> software that isn't itself GPL'd from being combined with GPL'd software.
> The issue is not permission to distribute this driver, the issue is
> permission to distribute the *kernel*. The kernel's license prohibits
> distrubiting it in combination with works that have licenses more
> restrictive than the GPL.

That better be bogus, or else vendors are going to be very upset that
they can't ship the kernel with, say, trademarked images. For example,
Mozilla's trademark on their artwork is fairly restrictive, or the
Mandrake Firewall product (if that's even still around - I don't keep
up).

-Erik
> 
> > >     This firmware may not be modified and may only be used with
> > >     Keyspan hardware.
> 
>        That's more restrictive than the GPL. So if you link this with a GPL'd
> work, the entirety must be distributed under the GPL, which you can't do
> since you can't authorize the unrestricted use of the firmware
> 
> > > which makes the kernel as whole unredistributable.  A similar license
> 
>        Bingo.
> 
> > Unredistributable? Am I mistaken? It says permission is given to
> > redistribute
> > this piece as part of the linux kernel. You just can't modify it.
> > Although it
> > is unquestionably not a very permissive license, it's inclusion is not
> > detrimental to the kernel.
> 
>        He didn't say this made the firmware unredistributable, he said it made the
> *kernel* unredistributable. Since you can't GPL the firmware, the kernel as
> a whole is not GPL. You cannot distribute a non-GPL Linux kernel because the
> GPL prohibits it as the GPL applies to everything else in the kernel
> 
> > Please correct me if I am wrong.
> 
>        You *definitely* are wrong. The entirety of the GPL would be negated if you
> were correct.
> 
>        DS
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
