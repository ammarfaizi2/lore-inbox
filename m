Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbUADSnE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 13:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbUADSnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 13:43:04 -0500
Received: from gprs214-164.eurotel.cz ([160.218.214.164]:27521 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261892AbUADSnB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 13:43:01 -0500
Date: Sun, 4 Jan 2004 19:44:24 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: gaim problems in 2.6.0
Message-ID: <20040104184424.GC344@elf.ucw.cz>
References: <20040104172535.GA322@elf.ucw.cz> <20040104183712.GT1882@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040104183712.GT1882@matchmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I'm having bad problems with gaim... When I run gaim, my machine tends
> > to freeze hard (no blinking leds). I'm running vesafb -> that should
> > rule out X problems. Machine is rather strange pre-production athlon64
> > noteook, but I'm running 32-bit (on 32-bit kernel), and I can run gaim
> > under 2.4.X kernel.
> 
> Are you using debian(IIRC, you are, but maybe not on this machine?)?
> 
> Are you using the old version in debian stable?  Id suggest upgrading to the
> new version available in testing, or possibly unstable (probably only
> problems compiling on non-i386 arches).

Yep, this is debian testing machiene, and it looks up-to-date (with
respect to testing):

root@amd:~# apt-get install gaim
Reading Package Lists... Done
Building Dependency Tree... Done
Sorry, gaim is already the newest version.

Anyway... I was running as normal user. I should not be able to crash
machine no matter what software I run. (And vesafb pretty much points
to kernel fault).

									Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
