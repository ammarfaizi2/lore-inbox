Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262703AbTCYQDg>; Tue, 25 Mar 2003 11:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262705AbTCYQDg>; Tue, 25 Mar 2003 11:03:36 -0500
Received: from popmail.goshen.edu ([199.8.232.22]:18657 "EHLO mail.goshen.edu")
	by vger.kernel.org with ESMTP id <S262703AbTCYQDe>;
	Tue, 25 Mar 2003 11:03:34 -0500
Subject: Re: 3ware driver errors
From: Ezra Nugroho <ezran@goshen.edu>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200303251626.49516.roy@karlsbakk.net>
References: <20030324212813.GA6310@osiris.silug.org>
	<20030325031225.GA6851@osiris.silug.org>
	<1048605943.20862.10731.camel@ezran.goshen.edu> 
	<200303251626.49516.roy@karlsbakk.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9.7x.1) 
Date: 25 Mar 2003 11:26:35 -0500
Message-Id: <1048609595.5413.3.camel@ezran.goshen.edu>
Mime-Version: 1.0
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yeah, but that's IBM drives, We were talking about the WDC -JB/BB.

I would be interested to listen to other WDJ sub 180G users who have the
same problem.
Anyone?



On Tue, 2003-03-25 at 10:26, Roy Sigurd Karlsbakk wrote:
> I'm running 2x8-port 3ware with 8 IBM 120gig disks on each controller in raid 
> 5. this has been running stably for half a year (that is - since I installed 
> it).
> 
> On Tuesday 25 March 2003 16:25, Ezra Nugroho wrote:
> > I have 8 120GB in a raid 5.
> > Although the site doesn't say that the 120s are affected, I have gotten
> > my raid to be degraded because one drive disappeared.
> > I got the same error message.
> >
> > I am not sure if I want to upgrade the firmware, however, I am not sure
> > my array is stable either...
> >
> > On Mon, 2003-03-24 at 22:12, Steven Pritchard wrote:
> > > On Mon, Mar 24, 2003 at 06:25:08PM -0700, Jeff V. Merkey wrote:
> > > > The person at WD to contact with specifics is listed below.
> > >
> > > Thanks for the pointer.  I have a lot of these WD drives...
> > >
> > > > We have seen it on the 180GB drives, but the 200GB are also affected.
> > >
> > > I don't suppose you've heard if the 160GB drives are affected, have
> > > you?  The page on support.wdc.com that someone else referred to
> > > specifically mentions the 200s and the 180s, but I see no mention of
> > > the 160s.
> > >
> > > Steve
> > > --
> > > steve@silug.org           | Southern Illinois Linux Users Group
> > > (618)398-7360             | See web site for meeting details.
> > > Steven Pritchard          | http://www.silug.org/
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > > in the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> -- 
> Roy Sigurd Karlsbakk, Datavaktmester
> ProntoTV AS - http://www.pronto.tv/
> Tel: +47 9801 3356
> 
> Computers are like air conditioners.
> They stop working when you open Windows.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


