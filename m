Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbUADShT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 13:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264347AbUADShT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 13:37:19 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:18835 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S263806AbUADShS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 13:37:18 -0500
Date: Sun, 4 Jan 2004 10:37:12 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: gaim problems in 2.6.0
Message-ID: <20040104183712.GT1882@matchmail.com>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20040104172535.GA322@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040104172535.GA322@elf.ucw.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 04, 2004 at 06:25:36PM +0100, Pavel Machek wrote:
> Hi!
> 

Hi Pavel!

> I'm having bad problems with gaim... When I run gaim, my machine tends
> to freeze hard (no blinking leds). I'm running vesafb -> that should
> rule out X problems. Machine is rather strange pre-production athlon64
> noteook, but I'm running 32-bit (on 32-bit kernel), and I can run gaim
> under 2.4.X kernel.

Are you using debian(IIRC, you are, but maybe not on this machine?)?

Are you using the old version in debian stable?  Id suggest upgrading to the
new version available in testing, or possibly unstable (probably only
problems compiling on non-i386 arches).

The debian package maintainer doesn't like the version in stable at all, but
policy dictates that only security fixes and such go in the stable series...

  Version Table:
      1:0.72-1 0
           711 http://http.us.debian.org unstable/main Packages
      1:0.64-3 0
           722 http://http.us.debian.org testing/main Packages
      1:0.58-2.3 0
           722 http://security.debian.org stable/updates/main Packages
