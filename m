Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292935AbSBVRZt>; Fri, 22 Feb 2002 12:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292938AbSBVRZk>; Fri, 22 Feb 2002 12:25:40 -0500
Received: from ns.ithnet.com ([217.64.64.10]:2835 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S292935AbSBVRZ1>;
	Fri, 22 Feb 2002 12:25:27 -0500
Date: Fri, 22 Feb 2002 18:19:50 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: alan@lxorguk.ukuu.org.uk, egberts@yahoo.com, lkml@secureone.com.au,
        linux-kernel@vger.kernel.org, techsupport@itexinc.com
Subject: Re: Dlink DSL PCI Card
Message-Id: <20020222181950.2fa06bb3.skraw@ithnet.com>
In-Reply-To: <20020222113600.F14673@redhat.com>
In-Reply-To: <20020220185044.31163.qmail@web10502.mail.yahoo.com>
	<E16dcnl-0004Wd-00@the-village.bc.nu>
	<20020222113600.F14673@redhat.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2002 11:36:00 -0500
Benjamin LaHaise <bcrl@redhat.com> wrote:

> I did some digging on the chipset used by the dlink card, and its made by the 
> folks at http://www.itexinc.com/ .  They claim Linux support, but only in the 
> form of an infrequently updated binary only module that is only available 
> through OEMs.  Unfortunately, they're uncooperative in providing documentation 
> for writing an open source driver.  It would be Really Nice if the guidelines 
> on the use of the Linux trademark prevented claims of Linux support without 
> driver source (ie, forcing binary only module drivers to be marketed as 
> "partial Linux support through kernel specific binary modules").

I guess I would prefer the hard line: if it states "linux support" there has to be a driver source - or at least full docs for _any_ requesting parties. Otherwise the trademark should not be useable at all. If you provide several "stages" of support, poor "Aunt Tilly" user (is this already tm'ed? :-) won't be able to understand the difference - and you distro-guys (this is not meant to be a BadName) want this type of user to a certain extent.
But this is a very purist point of view.

Beat me,
Stephan


