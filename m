Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267978AbTBMGrp>; Thu, 13 Feb 2003 01:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267979AbTBMGro>; Thu, 13 Feb 2003 01:47:44 -0500
Received: from pop.gmx.net ([213.165.64.20]:59463 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S267978AbTBMGro>;
	Thu, 13 Feb 2003 01:47:44 -0500
Date: Thu, 13 Feb 2003 07:57:30 +0100
From: Marc Giger <gigerstyle@gmx.ch>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: tpepper@louise.pinerecords.com, linux-kernel@vger.kernel.org,
       jt@hpl.hp.com
Subject: Re: Cisco Aironet 340 oops with 2.4.20
Message-Id: <20030213075730.16f495c7.gigerstyle@gmx.ch>
In-Reply-To: <20030213005443.GA11154@louise.pinerecords.com>
References: <20030210125342.4462c25b.gigerstyle@gmx.ch>
	<20030212161850.A2088@jose.vato.org>
	<20030213005443.GA11154@louise.pinerecords.com>
X-Mailer: Sylpheed version 0.8.9claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Feb 2003 01:54:43 +0100
Tomas Szepe <szepe@pinerecords.com> wrote:

> > [tpepper@vato.org]
> > 
> > I've had oopses in 2.4.19 if I leave Cisco's acu utility running while
> > I have much net activity.  Haven't looked to see if it still happens
> > in 2.4.20 or expended the effort to get better debug info.  I'm using
> > a cisco 352lmc card fwiw.
> 
> Also the driver deterministically oopses upon the rmmod of airo.o.
> It's been like that since 2.4.18 or so.

I've never made this experience..I use the driver for more than 2 years.
On my laptop the driver will be unloaded 2-3 times per day...no oops..

Interesting is that some of my friends use the same card and the same driver / kernel and they don't have any problems..
Perhaps my card is defective? How can I test it?

greets

Marc
