Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265866AbSIRJgn>; Wed, 18 Sep 2002 05:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265867AbSIRJgm>; Wed, 18 Sep 2002 05:36:42 -0400
Received: from [195.39.17.254] ([195.39.17.254]:1920 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S265866AbSIRJgl>;
	Wed, 18 Sep 2002 05:36:41 -0400
Date: Tue, 17 Sep 2002 15:34:09 +0000
From: Pavel Machek <pavel@suse.cz>
To: John Levon <movement@marcelothewonderpenguin.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: vesafb one pixel left?!
Message-ID: <20020917153409.A39@toy.ucw.cz>
References: <20020915181632.GA188@elf.ucw.cz> <20020915182838.GA84263@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020915182838.GA84263@compsoc.man.ac.uk>; from movement@marcelothewonderpenguin.com on Sun, Sep 15, 2002 at 07:28:38PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > On 2.5.34 I noticed that one pixel at the left was missing. I switched
> > consoles and problem went away. Weird.
> 
> I have had pixel droppings and missing pixels with vesafb for as long as
> I remember (that is, years)

2.4.X works perfectly on same hardware.

 Actually vesafb is in so bad state I often need to ^L in emacs because
of font corruption. One pixel left was merely first thing I saw.

								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

