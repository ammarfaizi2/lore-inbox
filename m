Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262659AbRE0ABP>; Sat, 26 May 2001 20:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262675AbRE0ABG>; Sat, 26 May 2001 20:01:06 -0400
Received: from zeus.kernel.org ([209.10.41.242]:20146 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262660AbRE0ABA>;
	Sat, 26 May 2001 20:01:00 -0400
Message-ID: <20010525144446.A15304@bug.ucw.cz>
Date: Fri, 25 May 2001 14:44:46 +0200
From: Pavel Machek <pavel@suse.cz>
To: Alexander Viro <viro@math.psu.edu>, Aaron Lehmann <aaronl@vitelus.com>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>, adam@yggdrasil.com,
        linux-kernel@vger.kernel.org
Subject: Re: Fwd: Copyright infringement in linux/drivers/usb/serial/keyspan*fw.h
In-Reply-To: <20010524230321.B23155@vitelus.com> <Pine.GSO.4.21.0105250229220.24864-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.GSO.4.21.0105250229220.24864-100000@weyl.math.psu.edu>; from Alexander Viro on Fri, May 25, 2001 at 02:34:05AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > explicit about defining source code:
> > 	The source code for a work means the preferred form of the work for
> > 	making modifications to it.
> 
> Erm... May I point you to the sysdep/libm-ieee754/e_j0.c? There's a bunch
> of constants of unknown origin. If you want to modify the implementation
> you most certainly want more than numeric values.
> 
> Same goes for any tables that contain anything besides well-known constants.

Imagine the hell opening when you generate table of random numbers
with hardware generator :-). How do you write source of hardware
random generator?
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
