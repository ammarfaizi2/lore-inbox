Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750961AbVHLKZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbVHLKZG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 06:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbVHLKZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 06:25:06 -0400
Received: from nproxy.gmail.com ([64.233.182.207]:23839 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750961AbVHLKZF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 06:25:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=F5zf2rLlAui8By60s358sHCOfLBAtL/amZM4578mvaLUY04h+yZlm5z/cdRi2FVGebw6FwdxstUyaQHvB3O8twm5tWFWeO5UsY7iTRD90BpXfewR24+IhVHwqJ71MVtprtDeTzPMjA66l5KXHTbh1UPw6P/fe9zw2kyiMoedhcQ=
Message-ID: <6278d222050812032446b583e4@mail.gmail.com>
Date: Fri, 12 Aug 2005 11:24:59 +0100
From: Daniel J Blueman <daniel.blueman@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SATA status report updated
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As stability is a concern, why not get the ATA passthru work in
sooner, then follow up with the SMART support after the passthru code
has had time to mature?

IMHO, the passthru work is good value alone, as there is currently no
way to adjust various parameters (AM, spindown time, ...) of SATA
disks right now.

Rob van Nieuwkerk wrote:
> On Fri, 12 Aug 2005 01:09:12 -0400
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
> Hi Jeff,
> 
> > Things in SATA-land have been moving along recently, so I updated the 
> > software status report:
> > 
> > 	http://linux.yyz.us/sata/software-status.html
> 
> Is any progress made on SMART support ?
> I've been reading "SMART support will be integrated very soon"
> for a very long time now .. :-)
> 
> > Thanks to all the hard-working SATA contributors!
> 
> Yup, thanks to you & them.  SATA has been working perfect in my system
> since I started using it 10 months ago !
> 
> 	greetings,
> 	Rob van Nieuwkerk
___
Daniel J Blueman
