Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266994AbTBCT73>; Mon, 3 Feb 2003 14:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267023AbTBCT6Z>; Mon, 3 Feb 2003 14:58:25 -0500
Received: from [195.39.17.254] ([195.39.17.254]:3588 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267021AbTBCTyq>;
	Mon, 3 Feb 2003 14:54:46 -0500
Date: Mon, 3 Feb 2003 16:50:42 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andi Kleen <ak@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.59 morse code panics
Message-ID: <20030203155042.GD480@elf.ucw.cz>
References: <20030131104326.GF12286@louise.pinerecords.com.suse.lists.linux.kernel> <200301311112.h0VBCv00000575@darkstar.example.net.suse.lists.linux.kernel> <20030131132221.GA12834@codemonkey.org.uk.suse.lists.linux.kernel> <1044025785.1654.13.camel@irongate.swansea.linux.org.uk.suse.lists.linux.kernel> <p73hebpqqn4.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73hebpqqn4.fsf@oldwotan.suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > On Fri, 2003-01-31 at 13:22, Dave Jones wrote:
> > > Or you could put down the crackpipe and run a serial console between
> > > the two boxes. Or even netconsole would make more sense
> > > (and be a lot more reliable).
> > 
> > A lot of newer laptops do not have serial ports. While morse code may
> > be a little silly the general purpose hook  it needs to be done 
> > cleanly is considerably more useful
> 
> And how many users and how many kernel hackers are able to decode
> morse on the fly? Are you going to explain to users
> "to debug this you'll need to learn morse" ?

If it is message "could not mount ext2 on /dev/hda2" I guess I could
catch enough of it to be usefull.

> I admit I was the on who got this ball running by suggesting it "as an 
> exercise for the reader" in the original panic blink code, but
> guys this was intended as a JOKE, not serious. Please get over it
> and don't merge that silly code.

Its not *that* silly. Simple extension of "blink leds on panic".

								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
