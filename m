Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266827AbRHWQ3Q>; Thu, 23 Aug 2001 12:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268900AbRHWQ3G>; Thu, 23 Aug 2001 12:29:06 -0400
Received: from pk.nord-com.net ([213.168.202.34]:52364 "EHLO pk.nord-com.de")
	by vger.kernel.org with ESMTP id <S266827AbRHWQ2w>;
	Thu, 23 Aug 2001 12:28:52 -0400
Date: Thu, 23 Aug 2001 18:24:26 +0200
From: Roland Bauerschmidt <rb@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Will 2.6 require Python for any configuration ? (CML2)
Message-ID: <20010823182426.A1714@newton.bauerschmidt.eu.org>
Mail-Followup-To: Roland Bauerschmidt <rb@debian.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010822030807.N120@pervalidus> <20010823140555.A1077@newton.bauerschmidt.eu.org> <20010823103620.A6965@kittpeak.ece.umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010823103620.A6965@kittpeak.ece.umn.edu>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob Glamm wrote:
> I bet the same number of people still compile their own kernels.
> However, the *percentage* of people that still compile their own
> kernels probably keeps shrinking as the number of people using
> Linux increases.

Of course, this is what I meant.

> Why isn't ncurses a pain?  For the same reason ncurses wasn't a
> pain when 'make menuconfig' (lxdialog) was introduced (yes, I did many a 
> 'make config'):  curses/ncurses was already on just about every
> system running Linux - it was built into the text editor.

It probably still is, but not every *user* that might want to compile a
kernel himself has the ncurses development files installed. Instead of
installing those he might as well install python (which most normal
users can use probably a lot better since the kernel wouldn't be the
only thing depending on it)...

> It does surprise me that Linus would actually allow this to happen.
> It's been my impression that he favors a clean, elegant solution.
> Maybe it's just me, but adding a dependency solely for the sake of
> building the kernel doesn't strike me as very clean or elegant.

I have to admit that I don't really know anything about CML at all (so
my points might be wrong), but I personally would favour a nice
replacement of 'make menuconfig' written in python.

Roland

-- 
Roland Bauerschmidt
