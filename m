Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318369AbSH0VEI>; Tue, 27 Aug 2002 17:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318389AbSH0VEH>; Tue, 27 Aug 2002 17:04:07 -0400
Received: from [195.39.17.254] ([195.39.17.254]:18304 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S318369AbSH0VDP>;
	Tue, 27 Aug 2002 17:03:15 -0400
Date: Tue, 27 Aug 2002 14:47:51 +0000
From: Pavel Machek <pavel@suse.cz>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Jesper Juhl <jju@dif.dk>, linux-kernel@vger.kernel.org
Subject: Re: Problem determining number of CPUs
Message-ID: <20020827144751.J35@toy.ucw.cz>
References: <20BF5713E14D5B48AA289F72BD372D6821CBA0@AUSXMPC122.aus.amer.dell.com> <1029940635.7255.185.camel@jju_lnx.backbone.dif.dk> <3D65DF4D.68EEA449@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3D65DF4D.68EEA449@aitel.hist.no>; from helgehaf@aitel.hist.no on Fri, Aug 23, 2002 at 09:07:57AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > In the case of 4 HT capable CPU's it could be reported like
> > 
> > 8 CPUs (4 physical)
> > 
> Or 8 CPUs (4 chips) 
> 2 cpus on a chip may be counterintuitive to some, but there
> isn't anything special about it.  They aren't really 
> less "physical".

But p4 is not 2cpus on a chip. Its one cpu two register sets.

								Pavel

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

