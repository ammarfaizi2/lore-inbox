Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318422AbSHENEY>; Mon, 5 Aug 2002 09:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318425AbSHENEY>; Mon, 5 Aug 2002 09:04:24 -0400
Received: from mail-fe71.tele2.ee ([212.107.32.235]:56206 "HELO everyday.com")
	by vger.kernel.org with SMTP id <S318422AbSHENEY> convert rfc822-to-8bit;
	Mon, 5 Aug 2002 09:04:24 -0400
Date: Mon, 5 Aug 2002 15:07:55 +0200
Message-Id: <200208051307.g75D7th18537@everyday.ee>
From: "Thomas Munck Steenholdt" <tmus@get2net.dk>
Cc: linux-kernel@vger.kernel.org
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Sv: i810 sound broken...
MIME-Version: 1.0
X-EdMessageId: 110c1d205e5f4d154c4b115758574b575752421c535f5f105d1d58505f5c1b154c101
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 2002-08-05 at 12:45, Thomas Munck Steenholdt wrote:
> > > The changes in the recent i810 audio are
> > > - Being more pessimistic in our interpretation of codec power up
> > > - Turning on EAPD in case the BIOS didn't do so at boot up
> > >
> > > Longer term full EAPD control as we do with the cs46xx is on my
> list,
> > > paticularly as i8xx laptops are becoming common . (EAPD is the
> amplifier
> > > power controller)
> >
> > That's strange - I get the same scratchy sounds on 2.4.19 as I did on
> 2.4.18
> > and a couple of the 2.4.19-pre's... Is there anything I should try, to
> > make sure things are configged / built correctly..?
> 
> What was the last tree that worked correctly on your box ?
> 
> Alan
> 

Actually I have never had it working on this box... It's my first one with an i810... 

Thomas

-- Send gratis SMS og brug gratis e-mail på Everyday.com -- 

