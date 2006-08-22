Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbWHVRAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWHVRAa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 13:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWHVRAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 13:00:30 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:53682 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932125AbWHVRAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 13:00:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lsQQJjURSfXIPT5PpWCUvKyxLuY2zZDa/6UC9VEEseUrOYSlk3msDm0KWKS40p77gKZHECiiAbZtnoQeToKJkhCNJvLJpRVbaehOVv1iyNuhv4LTqU45hcDGc/knG9f0/ZJg1b2gXOdbrNbUZi+zR/HM/SIN0SXUJR1y+nZuQXA=
Message-ID: <b6a2187b0608221000p4abc84d2mf5da6dc45dd30960@mail.gmail.com>
Date: Wed, 23 Aug 2006 01:00:27 +0800
From: "Jeff Chua" <jeff.chua.linux@gmail.com>
To: "Juha Yrjola" <juha.yrjola@solidboot.com>
Subject: Re: 2GB MMC/SD cards
Cc: "Daniel Drake" <dan@reactivated.net>,
       "Pierre Ossman" <drzeus-list@drzeus.cx>,
       "Matt Reimer" <mattjreimer@gmail.com>, linux-kernel@vger.kernel.org,
       rmk+lkml@arm.linux.org.uk
In-Reply-To: <44EB2083.8080902@solidboot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <447AFE7A.3070401@drzeus.cx>
	 <f383264b0606031140l2051a2d7p6a9b2890a6063aef@mail.gmail.com>
	 <4481FB80.40709@drzeus.cx> <4484B5AE.8060404@drzeus.cx>
	 <44869794.9080906@drzeus.cx>
	 <20060607165837.GE13165@flint.arm.linux.org.uk>
	 <448738CD.8030907@drzeus.cx> <4488AC57.7050201@drzeus.cx>
	 <44DEFBA1.6060500@reactivated.net> <44EB2083.8080902@solidboot.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/06, Juha Yrjola <juha.yrjola@solidboot.com> wrote:

> > What's the status on this patch? A Gentoo user at
> > http://bugs.gentoo.org/142172 reports that it is required for him to be
> > able to access his card, so it definitely works in some form.
>
> I have to pitch in here.  This patch is required for some cards to
> operate reliably on the Nokia 770, and we've done quite a bit of
> interoperability testing already.
>
> Pierre, could you submit it to RMK's patch tracking system?

I've tested with 2GB and 4GB SD for 2.6.17 thru 2.6.18-rc4, and this
patch works. Would very much like to see this in the mainstream
2.6.18.

Thanks,
Jeff.
