Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265594AbRF1IIZ>; Thu, 28 Jun 2001 04:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265598AbRF1IIO>; Thu, 28 Jun 2001 04:08:14 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:49413 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265594AbRF1IIC>;
	Thu, 28 Jun 2001 04:08:02 -0400
Date: Thu, 28 Jun 2001 01:07:48 -0700
From: Greg KH <greg@kroah.com>
To: Patrick Dreker <patrick@dreker.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Cosmetic JFFS patch.
Message-ID: <20010628010748.A6957@kroah.com>
In-Reply-To: <Pine.LNX.4.33.0106271514260.7355-100000@penguin.transmeta.com> <01062809432100.00590@wintermute>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01062809432100.00590@wintermute>; from patrick@dreker.de on Thu, Jun 28, 2001 at 09:43:21AM +0200
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2001 at 09:43:21AM +0200, Patrick Dreker wrote:
> Hello...
> 
> Am Donnerstag, 28. Juni 2001 00:16 schrieb Linus Torvalds:
> > I don't _have_ any instances of my name being printed out to annoy the
> > user, so that's a very theoretical argument.
> 
> Err.... Just nitpicking...
> 
> dreker@wintermute:~> dmesg | grep -C Linus
> hub.c: 2 ports detected
> uhci.c:  Linus Torvalds, Johannes Erdfelt, Randy Dunlap, Georg Acher, Deti 
> Fliegl, Thomas Sailer, Roman Weissgaerber

Please look at the latest 2.4.6-pre tree.  This has been changed for a
while now.

thanks,

greg k-h
