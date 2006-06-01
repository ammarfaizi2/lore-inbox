Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbWFAWao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWFAWao (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 18:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWFAWao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 18:30:44 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:56210 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750812AbWFAWao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 18:30:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QvdHj2urbOlMaNyZQbb6Xm4YKoWmplhEy2jCVEqZ7UNhBwHUcNbI/wCDVpS8Ca8LdvK9+xevJLBIZSiYCNniTNmTY3z9tO537WOQHsDBDt+usdx27C3GIniVZgK2JhfbrQejXX+1/x+50McI0VrQcYhcEzP5kwfs5XdheGjUfq4=
Message-ID: <6bffcb0e0606011530u49648f3hb329b376423c1c22@mail.gmail.com>
Date: Fri, 2 Jun 2006 00:30:43 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Arjan van de Ven" <arjan@linux.intel.com>
Subject: Re: 2.6.17-rc5-mm2
Cc: "Andrew Morton" <akpm@osdl.org>, "Greg KH" <gregkh@suse.de>,
       "Ingo Molnar" <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <6bffcb0e0606011204t2ff23462o2a6d414c40b01bbc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060601014806.e86b3cc0.akpm@osdl.org>
	 <6bffcb0e0606010851n75b49d83u9f43136b3108886c@mail.gmail.com>
	 <1149182408.3115.75.camel@laptopd505.fenrus.org>
	 <6bffcb0e0606011204t2ff23462o2a6d414c40b01bbc@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> Hi Arjan,
>
> On 01/06/06, Arjan van de Ven <arjan@linux.intel.com> wrote:
> > On Thu, 2006-06-01 at 17:51 +0200, Michal Piotrowski wrote:
> > > Hi,
> > >
> > > On 01/06/06, Andrew Morton <akpm@osdl.org> wrote:
> > > >
> > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm2/
> > > >
> > >
> > > I don't know why, but first bug appears only when avahi-daemon is
> > > started. Second look like a problem with my camera.
> > > http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm2/bug_1.jpg
> > > http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm2/bug_2.jpg
> > >
> > > Here is config http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm2/mm-config
> >
> >
> > can you confirm this fixes it ?
> >
>
> Probably yes, I'm not 100% sure. I'll do some tests (do stupid things
> with camera while reboot).

Problem fixed, thanks.

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
