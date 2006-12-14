Return-Path: <linux-kernel-owner+w=401wt.eu-S932743AbWLNOSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932743AbWLNOSL (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 09:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932744AbWLNOSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 09:18:11 -0500
Received: from rrcs-24-153-217-226.sw.biz.rr.com ([24.153.217.226]:37518 "EHLO
	smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932743AbWLNOSK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 09:18:10 -0500
X-Greylist: delayed 1535 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 09:18:09 EST
Subject: Re: Linux 2.6.20-rc1
From: Steve WIse <swise@opengridcomputing.com>
To: Alessandro Suardi <alessandro.suardi@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       alan@lxorguk.ukuu.org.uk
In-Reply-To: <5a4c581d0612140559l6ecb2343o26dd31ace0cd7dd5@mail.gmail.com>
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org>
	 <5a4c581d0612140559l6ecb2343o26dd31ace0cd7dd5@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 14 Dec 2006 08:18:07 -0600
Message-Id: <1166105887.686.9.camel@linux-q667.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And the patch was reposted here:

http://marc.theaimsgroup.com/?l=linux-kernel&m=116594961106441&w=2


On Thu, 2006-12-14 at 14:59 +0100, Alessandro Suardi wrote:
> On 12/14/06, Linus Torvalds <torvalds@osdl.org> wrote:
> >
> > Ok, the two-week merge period is over, and -rc1 is out there.
> 
> Still need this libata-sff.c patch:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=116343564202844&q=raw
> 
>  to have my root device detected, ata_piix probe would otherwise
>  fail as described in this thread:
> 
> http://www.ussg.iu.edu/hypermail/linux/kernel/0612.0/0690.html
> 
> --alessandro
> 
> "...when I get it, I _get_ it"
> 
>      (Lara Eidemiller)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

