Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314238AbSDVQHA>; Mon, 22 Apr 2002 12:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314239AbSDVQG7>; Mon, 22 Apr 2002 12:06:59 -0400
Received: from [195.39.17.254] ([195.39.17.254]:37774 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S314238AbSDVQG6>;
	Mon, 22 Apr 2002 12:06:58 -0400
Date: Sun, 21 Apr 2002 19:01:48 +0000
From: Pavel Machek <pavel@suse.cz>
To: Kurt Garloff <kurt@garloff.de>, nick@snowman.net,
        linux-kernel@vger.kernel.org
Subject: Re: IDE/raid performance
Message-ID: <20020421190148.C155@toy.ucw.cz>
In-Reply-To: <20020417140045.GC27648@dark.x.dtu.dk> <Pine.LNX.4.21.0204171108480.3300-100000@ns> <20020417223626.D16821@gum01m.etpnet.phys.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> On Wed, Apr 17, 2002 at 11:15:15AM -0400, nick@snowman.net wrote:
> > to be about 25-30watts.  Each 1800+ MP puts out 66w of heat, meaning it
> > uses more than 66w (I couldn't find the power useage stats) 
> 
> Meaning that they consume 66w. All energy is tranfered to heat.
> (Where else would you expect energy to go? My CPUs don't do mechanical 
> work nor do they build up potential energy.)

But they drive other parts of mainboard. [Imagine  led on the mainboard but
powered from CPU. Imagine that led takes 3W (unrealistic).] Then CPU needs
66W from power supply but onlly makes heat from 63W.
								Pavel


-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

