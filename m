Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266908AbTATTkx>; Mon, 20 Jan 2003 14:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266851AbTATTkP>; Mon, 20 Jan 2003 14:40:15 -0500
Received: from [195.39.17.254] ([195.39.17.254]:3588 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S266848AbTATTjd>;
	Mon, 20 Jan 2003 14:39:33 -0500
Date: Sun, 19 Jan 2003 18:08:38 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Christoph Hellwig <hch@infradead.org>, GertJan Spoelman <kl@gjs.cc>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] via686a sensors support
Message-ID: <20030119170837.GA8637@elf.ucw.cz>
References: <200301121925.14095.kl@gjs.cc> <20030112183438.A13025@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030112183438.A13025@infradead.org>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > @@ -16,7 +16,7 @@
> >  	  while the kernel is running.  If you want to compile it as a module,
> >  	  say M here and read <file:Documentation/modules.txt>.
> > 
> > -	  The module will be called i2c-amd756.o.
> > +	  The module will be called i2c-amd756.ko.
> 
> Please don't submit unrelated changes in this patch.  While I agree with
> this documentation fix it's clearly a separate issue.

Please submit that documenation fixes through trivial patch
monkey. That should make sure they are not lost.

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
