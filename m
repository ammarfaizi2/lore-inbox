Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262182AbULCMSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbULCMSo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 07:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbULCMSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 07:18:43 -0500
Received: from penta.pentaserver.com ([216.74.97.66]:13777 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S262182AbULCMSD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 07:18:03 -0500
From: Manu Abraham <manu@kromtek.com>
Reply-To: manu@kromtek.com
Organization: Kromtek Systems
To: ram mohan <madhaviram123@yahoo.com>
Subject: Re: Contribute - How to
Date: Fri, 3 Dec 2004 16:16:22 +0400
User-Agent: KMail/1.6.2
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
References: <20041203101727.33227.qmail@web90003.mail.scd.yahoo.com>
In-Reply-To: <20041203101727.33227.qmail@web90003.mail.scd.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200412031616.22620.manu@kromtek.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - penta.pentaserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kromtek.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri December 3 2004 2:17 pm, ram mohan wrote:
> way suggested looks interesting ..
> i was thinking of contributing in terms of device
> drivers/low level stuff .. searching for a todo list
> in this area..
>
Well, there's lot to be done, and contributors are less. It's just an 
understanding of the hardware that you want to contribute to.

Contribution in the area of device drivers can range from small additions to 
existing drivers and or totally new and or large drivers totally from the 
ground up.

Well, it all depends just how well you know the hardware, writing a driver is 
nothing more than a technical description of what the hardware can do in a 
programming language.

Another area, could be sending in patches for bugs in existing drivers.


Manu

> --- Manu Abraham <manu@kromtek.com> wrote:
> > On Fri December 3 2004 8:39 am, ram mohan wrote:
> > > I am interested to work in the following areas:
> > > 1. embedded systems
> > > 2. networking
> > >
> > > I was wondering how can I contribute in embedded
> > > without actual hardware.
> >
> > Well, to contribute you should have the hardware and
> > or the documentation,
> > depend on what you would like to contribute. You can
> > work on with an initrd,
> > if you are looking at embedded development on the
> > x86 platform.
> >
> > Even a retarded old PC can be considered as a
> > development platform for x86
> > embedded development.
> >
> > Manu
> >
> > > Thanks.
> > >
> > > --- "Randy.Dunlap" <rddunlap@osdl.org> wrote:
> > > > ram mohan wrote:
> > > > > Hi,
> > > > > I am willing to contribute to the development
> >
> > of
> >
> > > > Linux
> > > >
> > > > > kernel. I googled a bit and found that I
> >
> > should
> >
> > > > join
> > > >
> > > > > the list and then I can go ahead.
> > > > >
> > > > > I would like to know.
> > > > > 1. What are the features currently being
> >
> > worked
> >
> > > > upon?
> > > > It's all over the map:
> > > > Large-systems performance & scalability.
> > > > Embedded.  Desktop issues.
> > > > Journaling + extents-based filesystems.
> > > > Drivers (new development in Infiniband and
> >
> > iscsi).
> >
> > > > VM fixes.  Processor scheduling improvements.
> > > > IO scheduler improvements.
> > > > Fixing bugs.  :)
> > > >
> > > > > 2. Are there any things-to-do lists
> >
> > maintained?
> >
> > > > There are by some projects, others are more
> >
> > informal
> >
> > > > and
> > > > just discuss TODO on a mailing list.
> > > >
> > > > > 3. How are new features selected?
> > > >
> > > > a. scratch your favorite itch
> > > > or
> > > > b. what someone pays for
> > > >
> > > > What do you want to work on?
> > > >
> > > > > 4. Can I suggest new features?
> > > >
> > > > Of course.  But part of the Linux culture is
> >
> > that
> >
> > > > ideas/suggestions don't carry much weight.  It's
> > > > sometimes phrased as:
> > > >    Shut up and code.
> > > > or
> > > >    Show us the code.
> > > > so send patches too.  :)
> > > >
> > > > --
> > > > ~Randy
> > > > -
> > > > To unsubscribe from this list: send the line
> > > > "unsubscribe linux-kernel" in
> > > > the body of a message to
> >
> > majordomo@vger.kernel.org
> >
> > > > More majordomo info at
> > > > http://vger.kernel.org/majordomo-info.html
> > > > Please read the FAQ at  http://www.tux.org/lkml/
> > >
> > > __________________________________
> > > Do you Yahoo!?
> > > All your favorites on one personal page – Try My
> >
> > Yahoo!
> >
> > > http://my.yahoo.com
> > > -
> > > To unsubscribe from this list: send the line
> >
> > "unsubscribe linux-kernel" in
> >
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at
> >
> > http://vger.kernel.org/majordomo-info.html
> >
> > > Please read the FAQ at  http://www.tux.org/lkml/
> >
> > -
> > To unsubscribe from this list: send the line
> > "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at
> > http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>
> __________________________________
> Do you Yahoo!?
> Yahoo! Mail - 250MB free storage. Do more. Manage less.
> http://info.mail.yahoo.com/mail_250
