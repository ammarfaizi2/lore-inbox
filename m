Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266319AbUHWAHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266319AbUHWAHi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 20:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266916AbUHWAHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 20:07:38 -0400
Received: from LPBPRODUCTIONS.COM ([68.98.211.131]:18914 "HELO
	lpbproductions.com") by vger.kernel.org with SMTP id S266319AbUHWAHh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 20:07:37 -0400
From: Matt Heler <lkml@lpbproductions.com>
Reply-To: lkml@lpbproduction.scom
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PROBLEM: Promise Fast Track SX6000 i2o driver.
Date: Sun, 22 Aug 2004 17:07:34 -0700
User-Agent: KMail/1.7
Cc: Piotr Goczal <bilbo@mazurek.man.lodz.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0408211012500.2571@mazurek.man.lodz.pl> <Pine.LNX.4.58.0408221936270.2571@mazurek.man.lodz.pl> <1093200494.24905.7.camel@localhost.localdomain>
In-Reply-To: <1093200494.24905.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408221707.34851.lkml@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have an sx6000 here, and I can confirm the same results as Piotr. So if 
anything does come out , I would not mind giving it a test try too.

Matt H. 




On Sunday 22 August 2004 11:48 am, Alan Cox wrote:
> On Sul, 2004-08-22 at 18:41, Piotr Goczal wrote:
> > If Promise has changed their policy and went off from i2o "standard" it's
> > the good idea, but unfortunatelly I'm c/c++ newbie :-(. I can offer
> > you access to my test machine with SX6000 installed. I even have to two
> > SX 6000 so you want you can test new and old version of firmware in the
> > same time.
>
> Can you forward me their current driver. I'm busy with other stuff for
> at least the next week, and then have to see about getting the IDE stuff
> sorted further with Bartlomiej but I'll take a look. I've got the
> original Supertrak 100 so between us we can test all three.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
