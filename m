Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265777AbUFINL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265777AbUFINL3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 09:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265772AbUFINKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 09:10:37 -0400
Received: from mta06-svc.ntlworld.com ([62.253.162.46]:43906 "EHLO
	mta06-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S263663AbUFINHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 09:07:55 -0400
Date: Wed, 9 Jun 2004 14:07:51 +0100
From: Mike Jagdis <mjagdis@eris-associates.co.uk>
To: Manu Abraham <manu@kromtek.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-abi dead?
Message-ID: <20040609130751.GA29507@eris-associates.co.uk>
References: <1086588439.8572.10.camel@ip68-12-228-23.ok.ok.cox.net> <200406071515.26769.manu@kromtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406071515.26769.manu@kromtek.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

iBCS ceased when I decided that "enough" vendors were targetting
Linux as a Tier-1 platform and what was left was legacy proprietry
stuff that either worked or would be painful to fix. iBCS then
became linux-abi which ported to newer kernels and added UnixWare
support. I guess there just isn't enough SYSV stuff left to
keep any momentum behind linux-abi anymore either...

SCO stated a long time ago that they saw nothing in linux-abi
to worry them.

Which is kind of interesting because iBCS started life pretty
much as a way for Eric Youngdale to test his ELF loader code,
which subsequently moved into the main kernel.

(iBCS CVS is still available on http://sf.net/projects/ibcs
even if nothing else is. It doesn't go back quite to the
start - I think my initial import was 1993...)

Mike

On Mon, Jun 07, 2004 at 03:15:26PM +0400, Manu Abraham wrote:
> Hi,
>         Wouldn't SCO be too happy to have a valid point for  lawsuit ?
> 
> Regards,
> Manu
> 
> On Monday 07 Jun 2004 10:07 am, Steve Bergman wrote:
> > I just moved a server over to Fedora Core 2 (kernel 2.6.6) and
> > discovered that there is a need to run an old SCO binary.
> >
> > linux-abi.sf.net seems quite dead as a project.  Is there any comparable
> > support for for foreign binaries in for the 2.6.x series?
> >
> > Since even the developer and user mailing lists of the linux-abi project
> > seem quite dead, this seems an appropriate place to ask.
> >
> > Thanks,
> > Steve Bergman
> >
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
-- 
Mike Jagdis                        Web: http://www.eris-associates.co.uk
Eris Associates Limited            Tel: +44 7780 608 368
Reading, England                   Fax: +44 118 926 6974
