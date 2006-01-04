Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030299AbWADWVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbWADWVL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 17:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbWADWVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 17:21:11 -0500
Received: from mail.linicks.net ([217.204.244.146]:45516 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S1030299AbWADWVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 17:21:09 -0500
From: Nick Warne <nick@linicks.net>
To: Greg KH <greg@kroah.com>
Subject: Re: 2.6.14.5 to 2.6.15 patch
Date: Wed, 4 Jan 2006 22:20:59 +0000
User-Agent: KMail/1.9
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       webmaster@kernel.org
References: <200601041710.37648.nick@linicks.net> <200601042210.47152.nick@linicks.net> <20060104221549.GA13254@kroah.com>
In-Reply-To: <20060104221549.GA13254@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601042220.59637.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 January 2006 22:15, Greg KH wrote:

> > Then when 2.6.15 came out, that was it!  No patch for the 'latest stable
> > kernel release 2.6.14.5'.  It was GONE!
>
> That's because 2.6.15 is the latest stable release.
>
> > OK, I suppose we are all capable of getting back to where we are on
> > rebuilding to latest 'stable', but there _is_ a missing link for somebody
> > that doesn't know - and I think backtracking patches isn't really the way
> > to go if the 'latest stable release' isn't catered for.
>
> Um, it is, see my sentance above.  And if you want to download older
> stable releases, you can jump to the proper directory, how long do you
> want us to put older stable releases on the main page for?  :)

OK, I see what you mean, but 2.6.14 wasn't the latest 'release' - 2.6.14.5 was 
(according to kernel.org).  Yet there is no upgrade path for that build (or 
any other .x releases)

It is a bit of a mess really.

Nick
-- 
"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb
My quake2 project:
http://sourceforge.net/projects/quake2plus/
