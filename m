Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269318AbRHWRnL>; Thu, 23 Aug 2001 13:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269391AbRHWRnB>; Thu, 23 Aug 2001 13:43:01 -0400
Received: from [128.55.19.230] ([128.55.19.230]:34453 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S269318AbRHWRms>; Thu, 23 Aug 2001 13:42:48 -0400
Message-ID: <3B853F83.C31F8503@lbl.gov>
Date: Thu, 23 Aug 2001 10:38:11 -0700
From: Thomas Davis <tadavis@lbl.gov>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
CC: Roger Larsson <roger.larsson@norran.net>,
        linux-usb-users@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Klaus Mueller <klmuell@web.de>
Subject: Re: [Linux-usb-users] Report: Sony Handycam USB and Linux 2.4.9-pre2
In-Reply-To: <200108141108.f7EB8v612177@mailgate3.cinetic.de> <200108142242.AAA22621@mailb.telia.com> <3B84628B.F998731C@lbl.gov> <200108231739.f7NHdIm16408@maild.telia.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Larsson wrote:
> 
> On Thursdayen den 23 August 2001 03:55, Thomas Davis wrote:
> > Roger Larsson wrote:
> > > Hi,
> > >
> > > [Note: I am not subscribed to linux-usb-users, please cc:]
> > >
> > > I have a Sony PC110E that has been working with a small patch since 2.4.0
> > > But with 2.4.9-pre2 it does not work anymore...
> >
> > Hmm.. I just got this camera (except it's an NTSC version), and I get
> >
> > "not a block device" when I try to mount it.
> 
> try with fdisk (or cfdisk) it works...
> 

fdisk works fine.  it's when I try to mount it I get the error.

I'll try the patch and see what happens..

-- 
------------------------+--------------------------------------------------
Thomas Davis		| ASG Cluster guy
tadavis@lbl.gov		| 
(510) 486-4524		| "80 nodes and chugging Captain!"
