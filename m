Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318488AbSHEOUd>; Mon, 5 Aug 2002 10:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318497AbSHEOUc>; Mon, 5 Aug 2002 10:20:32 -0400
Received: from mx7.sac.fedex.com ([199.81.194.38]:62224 "EHLO
	mx7.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S318488AbSHEOUb>; Mon, 5 Aug 2002 10:20:31 -0400
Date: Mon, 5 Aug 2002 21:51:34 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Thomas Munck Steenholdt <tmus@get2net.dk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Sv: i810 sound broken...
In-Reply-To: <1028555196.18130.36.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0208052149540.877-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 08/05/2002
 09:53:02 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 08/05/2002
 09:53:06 PM,
	Serialize complete at 08/05/2002 09:53:06 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 Aug 2002, Alan Cox wrote:

> On Mon, 2002-08-05 at 12:45, Thomas Munck Steenholdt wrote:
> > > The changes in the recent i810 audio are
> > > - Being more pessimistic in our interpretation of codec power up
> > > - Turning on EAPD in case the BIOS didn't do so at boot up
> > >
> > > Longer term full EAPD control as we do with the cs46xx is on my list,
> > > paticularly as i8xx laptops are becoming common . (EAPD is the amplifier
> > > power controller)
> >
> > That's strange - I get the same scratchy sounds on 2.4.19 as I did on 2.4.18
> > and a couple of the 2.4.19-pre's... Is there anything I should try, to
> > make sure things are configged / built correctly..?
>
> What was the last tree that worked correctly on your box ?

Works for me on all 2.4.19-prex and 2.4.19.

Jeff.


