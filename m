Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285747AbSADX21>; Fri, 4 Jan 2002 18:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285828AbSADX2R>; Fri, 4 Jan 2002 18:28:17 -0500
Received: from smtp1.ndsu.NoDak.edu ([134.129.111.146]:15113 "EHLO
	smtp1.ndsu.nodak.edu") by vger.kernel.org with ESMTP
	id <S285747AbSADX2H>; Fri, 4 Jan 2002 18:28:07 -0500
Subject: Re: PATCH 2.5.2.7: io.h cleanup and userspace nudge
From: Reid Hekman <reid.hekman@ndsu.nodak.edu>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20020104191632.GK28621@thune.mrc-home.com>
In-Reply-To: <200201041831.g04IVAD23320@vindaloo.ras.ucalgary.ca>
	<Pine.LNX.4.33.0201041940150.20620-100000@Appserv.suse.de>
	<200201041841.g04IflL23687@vindaloo.ras.ucalgary.ca> 
	<20020104191632.GK28621@thune.mrc-home.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 04 Jan 2002 17:28:06 -0600
Message-Id: <1010186893.1424.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-01-04 at 13:16, Mike Castle wrote:
> On Fri, Jan 04, 2002 at 11:41:47AM -0700, Richard Gooch wrote:
> > Not if you want a lightweight C library. Such as when running off a CF
> > card.
> 
> But aren't there better options for a lightweight C library than libc5?
> 
> At least that would involve using something that's being maintained.
> 

Yes indeed, something like this perhaps?

http://www.fefe.de/dietlibc/

Regards,
Reid
--
Ignorance of all things is an evil neither terrible nor excessive, nor
yet the greatest of all; but great cleverness and much learning, if they
be accompanied by a bad training, are a much greater misfortune. - Plato

