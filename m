Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261208AbSJHRSh>; Tue, 8 Oct 2002 13:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261281AbSJHRSh>; Tue, 8 Oct 2002 13:18:37 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:52890 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S261208AbSJHRSe>;
	Tue, 8 Oct 2002 13:18:34 -0400
Date: Tue, 8 Oct 2002 19:23:40 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Stian Jordet <liste@jordet.nu>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       Thomas Molina <tmolina@cox.net>
Subject: Re: Mouse/Keyboard problems with 2.5.38
Message-ID: <20021008192340.A26021@ucw.cz>
References: <20021008085842.A4412@ucw.cz> <1034097327.902.8.camel@chevrolet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1034097327.902.8.camel@chevrolet>; from liste@jordet.nu on Tue, Oct 08, 2002 at 07:14:19PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2002 at 07:14:19PM +0200, Stian Jordet wrote:
> tir, 2002-10-08 kl. 08:58 skrev Vojtech Pavlik:
> > 
> > > But now I decided I should try again. I got 2.5.38 booted after some
> > > initial trouble. But, I have a couple of weird problems. First, the
> > > mouse. I have a Logitech Cordless Optical mouse. With kernel 2.4.x I use
> > > MouseManPlusPS/2 as the XFree mouse-driver. Then I can use the wheel and
> > > the fourth button just as expected. But with kernel 2.5.38 neither the
> > > wheel or the fourth button works. I change protocol to IMPS/2 in XFree,
> > > and everything works like expected, but the fourth button works just
> > > like pussing the wheel (third button). This is excactly the same
> > > behavior as with 2.4.20-pre7 (that's why I use MouseManPlusPS/2). Anyone
> > > have a clue why this doesn't work with kernel 2.5.38?
> > 
> > Does it work when you use "ExplorerPS/2" instead?
> 
> Uhm, you answered that 26th september, and I replied the same day.Yes,
> it works perfect now :)

Sorry, found it again on the 2.5 problems kernel page. :)

> > > Second problem, if I press SHIFT+PAGEUP, my computer freezes. It spits
> > > out this message: "input: AT Set 2 keyboard on isa0060/serio0, and then
> > > it's dead. I have a Logitech cordless keyboard. 
> > 
> > It should be fixed in 2.5.39 or 2.5.40. Does it work fine on 2.5.41?
> 
> It does not. I'll answer your other mail instead :)

:)

-- 
Vojtech Pavlik
SuSE Labs
