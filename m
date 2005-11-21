Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750843AbVKUUR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbVKUUR0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 15:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbVKUURZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 15:17:25 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:42163 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750885AbVKUURZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 15:17:25 -0500
Date: Mon, 21 Nov 2005 21:17:14 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jody McIntyre <scjody@steamballoon.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/3] Add SCM info to MAINTAINERS
Message-ID: <20051121201714.GL29518@elf.ucw.cz>
References: <20051118173930.270902000@press.kroah.org> <20051118173106.GB20860@kroah.com> <20051120213846.GB2556@spitz.ucw.cz> <20051121201429.GE20781@conscoop.ottawa.on.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051121201429.GE20781@conscoop.ottawa.on.ca>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 21-11-05 15:14:29, Jody McIntyre wrote:
> On Sun, Nov 20, 2005 at 09:38:47PM +0000, Pavel Machek wrote:
> > >  W: Web-page with status/info
> > > +T: SCM tree type and URL.  Type is one of: git, hg, quilt.
> > >  S: Status, one of the following:
> > 
> > You are not actually putting urls there. url is git://kernel.org/...
> 
> Good point.  How should we fix this?  s/URL/location/ ?  I don't think
> we should put git://kernel.org... in the T: field since there are many
> valid ways of accessing this repository: git, http, rsync, ssh (if you
> have an account).

I'd do s/URL/location/...
								Pavel

-- 
Thanks, Sharp!
