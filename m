Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbWIUQAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbWIUQAn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 12:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbWIUQAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 12:00:21 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:21509 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751296AbWIUQAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 12:00:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DIe3Ww3ygY+Tiz0wfNPaxifboAPJoti5FDLgC7NwiJrsCT8LHDZYcH8UOttg0atI0bsFO5yzShCdB0AMBWF1dbSEF2dGEPNlJ+4nM3DPijrL31cOwhhn0ydcc3xTEtoBi5cg8J8nfVxj4FiaQJm7TUbOjpoHKatrOd99+uFJxr4=
Message-ID: <6d6a94c50609210900le553cedxe1bbbfb1ed8c679a@mail.gmail.com>
Date: Fri, 22 Sep 2006 00:00:16 +0800
From: Aubrey <aubreylee@gmail.com>
To: "Luke Yang" <luke.adi@gmail.com>
Subject: Re: [PATCH 2/4] Blackfin: Serial driver for Blackfin arch on 2.6.18
Cc: "Randy. Dunlap" <rdunlap@xenotime.net>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <489ecd0c0609210849r44a76be1h9ddbc308ba78d574@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <489ecd0c0609202033j4dd9a62fye81f99d61bff030d@mail.gmail.com>
	 <1158830784.11109.93.camel@localhost.localdomain>
	 <6d6a94c50609210223o5adf9bb5w7bfb70fb59094c85@mail.gmail.com>
	 <489ecd0c0609210257tb8daf0fl7603ff96e6e21c2e@mail.gmail.com>
	 <20060921083800.74649310.rdunlap@xenotime.net>
	 <489ecd0c0609210849r44a76be1h9ddbc308ba78d574@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

I think luke just assumed you acked the patch after we have done the
modification. But he'll remove it. Sorry for that.

Please comment the newest patch.
Thanks,
-Aubrey

On 9/21/06, Luke Yang <luke.adi@gmail.com> wrote:
> On 9/21/06, Randy.Dunlap <rdunlap@xenotime.net> wrote:
> > On Thu, 21 Sep 2006 17:57:03 +0800 Luke Yang wrote:
> >
> > > Great thanks. Here is the new patch:
> > >
> > > Signed-off-by: Luke Yang <luke.adi@gmail.com>
> > > Acked-by: Randy.Dunlap <rdunlap@xenotime.net>
> > > Acked-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
> >
> > I can't find an email where I acked this patch...
>  Sorry, I'll remove it.
> >
> > >  drivers/serial/Kconfig      |   44 ++
> > >  drivers/serial/Makefile     |    1
> > >  drivers/serial/bfin_5xx.c   |  906 ++++++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/serial_core.h |    3
> > >  4 files changed, 954 insertions(+)
> >
> > ---
> > ~Randy
> >
>
>
> --
> Best regards,
> Luke Yang
> luke.adi@gmail.com
>
