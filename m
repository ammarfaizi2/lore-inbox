Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265608AbTAJSD5>; Fri, 10 Jan 2003 13:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265643AbTAJSD5>; Fri, 10 Jan 2003 13:03:57 -0500
Received: from [195.39.17.254] ([195.39.17.254]:14340 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S265608AbTAJSD4>;
	Fri, 10 Jan 2003 13:03:56 -0500
Date: Wed, 8 Jan 2003 13:06:59 +0100
From: Pavel Machek <pavel@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: include order for i2c-amd8111
Message-ID: <20030108120658.GB592@zaurus>
References: <20030105231349.GA8714@elf.ucw.cz> <20030106004057.127332C0AA@lists.samba.org> <20030107114403.A5029@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030107114403.A5029@ucw.cz>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > It seems all linux then all asm is prefered order...
> > > 								> > Yes, but not for any great reason, AFAICT.  I think this comes under
> > the "too trivial" rule (ie.  I'll accept it from the author, but not
> > someone else).
> 
> The author (me ;) definitely doesn't mind you applying the patch, but
> would prefer if the one who pushed the 8111 driver into the kernel
> (Pavel) would update it to the version found in lm_sensors 2.7.0 at the
> same time.

Do you think you can mail me that file?

				Pavel

-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

