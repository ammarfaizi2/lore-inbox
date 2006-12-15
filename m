Return-Path: <linux-kernel-owner+w=401wt.eu-S1750843AbWLOImm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbWLOImm (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 03:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbWLOImm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 03:42:42 -0500
Received: from mail.first.fraunhofer.de ([194.95.169.2]:61206 "EHLO
	mail.first.fraunhofer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbWLOIml (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 03:42:41 -0500
X-Greylist: delayed 376 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Dec 2006 03:42:41 EST
Subject: Re: [PATCH] usbhid quirks for macbook(pro) (was: Re: Fwd: Re:
	[linux-usb-devel] usb initialization order (usbhid	vs. appletouch))
From: Soeren Sonnenburg <kernel@nn7.de>
To: Greg Kroah-Hartman <greg@kroah.com>
Cc: Joseph Fannin <jhf@columbus.rr.com>, Oliver Neukum <oliver@neukum.name>,
       Sergey Vlasov <vsu@altlinux.ru>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <1165716489.27637.7.camel@localhost.localdomain>
References: <1161856438.5214.2.camel@no.intranet.wo.rk>
	 <1162054576.3769.15.camel@localhost> <200610282043.59106.oliver@neukum.org>
	 <200610282055.29423.oliver@neukum.name> <1162067266.4044.2.camel@localhost>
	 <20061030101202.GB9265@nineveh.rivenstone.net>
	 <1165598367.19187.18.camel@localhost>
	 <1165716489.27637.7.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 15 Dec 2006 09:36:04 +0100
Message-Id: <1166171764.3507.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-12-09 at 21:08 -0500, Joseph Fannin wrote:
> On Fri, 2006-12-08 at 18:19 +0100, Soeren Sonnenburg wrote:
> 
> > ok, this patch was now in the mactel svn repository since about a month
> > and I've never ever seen a report about it failing. Also I asked on the
> > mailinglist for anyone having problems with that and got no answer,
> > execpt Joseph, the problem you have been seeing might have been that
> > one:
> > 
> > http://www.mail-archive.com/mactel-linux-devel@lists.sourceforge.net/msg00129.html
> > 
> > I would therefore hope it can be applied and thus appear in .20. I am
> > attaching the version that is now in mactel-svn (which also includes
> > geyser4 support).
> 
>     I've since gotten my Macbook's trackpad working with the Appletouch
> driver also, now, so make that no problems, please.
> 
>     I don't know what the problems I was seeing were anymore, but I
> think it was mostly the difficulty in getting it set up.  I understand
> that this should help fix that, and wish I hadn't tried to hold it up!

Greg,

I've noticed that this patch is not in 2.6.20-rc1. Could you please
comment on what is wrong with it / whether it will ever have a chance to
be accepted in the way it is done ? 

Thanks,
Soeren
