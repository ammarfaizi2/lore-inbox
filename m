Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293027AbSBVWaL>; Fri, 22 Feb 2002 17:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293026AbSBVWaA>; Fri, 22 Feb 2002 17:30:00 -0500
Received: from 20.208.phc.net ([208.185.198.20]:14493 "EHLO
	iteusa-nt.itexinc.com") by vger.kernel.org with ESMTP
	id <S293028AbSBVW3l> convert rfc822-to-8bit; Fri, 22 Feb 2002 17:29:41 -0500
Subject: RE: Dlink DSL PCI Card
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Fri, 22 Feb 2002 14:33:48 -0800
content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.0.4712.0
Message-ID: <E788BA1D236784409F3F7138F1EABFDDE4DF@iteusa-nt.itexinc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Dlink DSL PCI Card
Thread-Index: AcG7xcX+CkOexvgbTySx1hAll6Om4wAKhFaQ
From: "Dave Rattay [ITeX]" <Dave.Rattay@itexinc.com>
To: "Stephan von Krawczynski" <skraw@ithnet.com>,
        "Benjamin LaHaise" <bcrl@redhat.com>
Cc: <alan@lxorguk.ukuu.org.uk>, <egberts@yahoo.com>, <lkml@secureone.com.au>,
        <linux-kernel@vger.kernel.org>,
        "ITeX Tech Support" <techsupport@itexinc.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan,

    I am not sure if you actually requesting anything but here are some
points on this matter.  First and foremost we do not make these cards.
They are made by our customers that we supply chips for.  We do make the
drivers for these boards but they can then be customized by our
customers.  The point is that we do support Linux for our customers and
our customers are not really end-users.  Now since end-users are
indirectly our customers we do supply Linux drivers on request.  Also if
we cannot meet a request for any reason that information is added to our
Marketing data for future driver development.  Due to previous licensing
agreements we cannot release our source code to anyone including our
direct customers and there is no way around that.  Sorry.  Now if you
have a request for a driver please let me know the kernel version being
used as well as the ADSL protocol that you have.  I will see what I can
do to get you a usable driver.

Thank you for your interest in ITeX

Dave Rattay 
Applications Engineer 
Integrated Telecom Express, Inc 
400 Race St. 
San Jose, CA 95126 


-----Original Message-----
From: Stephan von Krawczynski [mailto:skraw@ithnet.com]
Sent: Friday, February 22, 2002 9:20 AM
To: Benjamin LaHaise
Cc: alan@lxorguk.ukuu.org.uk; egberts@yahoo.com; lkml@secureone.com.au;
linux-kernel@vger.kernel.org; ITeX Tech Support
Subject: Re: Dlink DSL PCI Card


On Fri, 22 Feb 2002 11:36:00 -0500
Benjamin LaHaise <bcrl@redhat.com> wrote:

> I did some digging on the chipset used by the dlink card, and its made
by the 
> folks at http://www.itexinc.com/ .  They claim Linux support, but only
in the 
> form of an infrequently updated binary only module that is only
available 
> through OEMs.  Unfortunately, they're uncooperative in providing
documentation 
> for writing an open source driver.  It would be Really Nice if the
guidelines 
> on the use of the Linux trademark prevented claims of Linux support
without 
> driver source (ie, forcing binary only module drivers to be marketed
as 
> "partial Linux support through kernel specific binary modules").

I guess I would prefer the hard line: if it states "linux support" there
has to be a driver source - or at least full docs for _any_ requesting
parties. Otherwise the trademark should not be useable at all. If you
provide several "stages" of support, poor "Aunt Tilly" user (is this
already tm'ed? :-) won't be able to understand the difference - and you
distro-guys (this is not meant to be a BadName) want this type of user
to a certain extent.
But this is a very purist point of view.

Beat me,
Stephan


