Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266204AbUJHXfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266204AbUJHXfe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 19:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266221AbUJHXfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 19:35:34 -0400
Received: from mail.kroah.org ([69.55.234.183]:1216 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266204AbUJHXfM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 19:35:12 -0400
Date: Fri, 8 Oct 2004 16:34:50 -0700
From: Greg KH <greg@kroah.com>
To: Roland Dreier <roland@topspin.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [openib-general] InfiniBand incompatible with the Linux kernel?
Message-ID: <20041008233450.GA1490@kroah.com>
References: <20041008202247.GA9653@kroah.com> <528yagn63x.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <528yagn63x.fsf@topspin.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2004 at 04:27:14PM -0700, Roland Dreier wrote:
> The increase in cost for the spec is rather unfortunate but I think
> it's orthogonal to any IP issues.  Since the Linux kernel contains a
> lot of code written to specs available only under NDA (and even
> reverse-engineered code where specs are completely unavailable), I
> don't think the expense should be an issue.

It isn't at all, just an odd side point.

> As for IP, as far as I know, there has been no change to any of the
> bylaws or other members agreements.

The "purchase a spec" agreement has changed, right?

> If there is some specific
> provision that concerns you, please bring it to our attention -- the
> IBTA in general and the IBTA steering committee in general have been
> very supportive of the OpenIB effort.  In fact, most of the IBTA
> steering commitee companies (Agilent, HP, IBM, InfiniCon, Intel,
> Mellanox, Sun, Topspin, and Voltaire) have been active participants in
> OpenIB development.  I would hope we can resolve any issues relating
> to open source and the Linux kernel.

What about the issue of not being able to use the spec for "commercial"
applications?  And doesn't the member agreement not cover anyone who
implements the spec, and then gives that implementation to someone who
is not a member?

> However, I would suspect that we'll find the USB, Firewire, Bluetooth,
> etc., etc. standards bodies all have very similar IP language in their
> bylaws and licenses.

No, the USB bylaws explicitly forbid any member company from putting in,
or trying to claim any IP that is in the USB specs.  That is something
that makes USB quite different from IB.

I haven't had the misfortune to have to go read the PCI SIG bylaws and
member agreement...

thanks,

greg k-h
