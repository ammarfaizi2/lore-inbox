Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265603AbTABRCK>; Thu, 2 Jan 2003 12:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265633AbTABRCK>; Thu, 2 Jan 2003 12:02:10 -0500
Received: from [195.39.17.254] ([195.39.17.254]:1540 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S265603AbTABRCI>;
	Thu, 2 Jan 2003 12:02:08 -0500
Date: Wed, 25 Dec 2002 18:58:57 +0100
From: Pavel Machek <pavel@suse.cz>
To: Rudmer van Dijk <rudmer@legolas.dynup.net>,
       Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.x console keyboard problem.
Message-ID: <20021225175857.GC1611@zaurus>
References: <20021223155048.GA19266@babylon.d2dc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021223155048.GA19266@babylon.d2dc.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> To cheat, just tap the Fn key twice when switching to X, to cheat better
> change your keymap to not have binds for ctrl-alt-Fn.
> 
> It seems very likely that while some cards can survive being poked at by
> the vgacon driver while the X driver is also talking to them, other
> cards have more, significant problems.
> > 
> > I have been seeing this since 2.5.50. 
> 
> But it did not at 2.5.49? That should definitely help him isolate it..

I believe  Ive seen the "both kernel and X write
to the screen" back in 2.2.X days on sparc machines.

-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

