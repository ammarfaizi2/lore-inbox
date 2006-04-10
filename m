Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWDJAbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWDJAbM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 20:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWDJAbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 20:31:12 -0400
Received: from xenotime.net ([66.160.160.81]:12684 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750747AbWDJAbL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 20:31:11 -0400
Date: Sun, 9 Apr 2006 17:33:28 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andrew Morton <akpm@osdl.org>
Cc: ncunningham@cyclades.com, zippel@linux-m68k.org, sam@ravnborg.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/19] kconfig: recenter menuconfig
Message-Id: <20060409173328.637d1523.rdunlap@xenotime.net>
In-Reply-To: <20060409153914.3fb468d3.akpm@osdl.org>
References: <Pine.LNX.4.64.0604091726550.23116@scrub.home>
	<20060409215520.GD30208@mars.ravnborg.org>
	<Pine.LNX.4.64.0604100001220.32445@scrub.home>
	<200604100932.00701.ncunningham@cyclades.com>
	<20060409153914.3fb468d3.akpm@osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Apr 2006 15:39:14 -0700 Andrew Morton wrote:

> Nigel Cunningham <ncunningham@cyclades.com> wrote:
> >
> > Hi.
> > 
> > On Monday 10 April 2006 08:10, Roman Zippel wrote:
> > > Hi,
> > >
> > > On Sun, 9 Apr 2006, Sam Ravnborg wrote:
> > > > > Further there is now a mix of left aligned and centered output,
> > > > > which is ugly
> > > >
> > > > So we should fix the rest too instead of reintroducing the old
> > > > behaviour.
> > >
> > > Well, I prefer the old behaviour.
> > 
> > I don't know if you want 2c worth from other people, but I liked menuconfig 
> > much better when it was more centred. This new 
> > 'everything-hard-against-the-left-margin' look is ugly, IMHO :)
> > 
> 
> It hardly seems to matter, given that the colours we use make the text
> invisible anyway..

You (anyone) can get alternate colors or monochrome here:
  http://www.xenotime.net/linux/patches/menuconfig-altcolor-mono.patch

The yellow highlight character shows up poorly for me.  OTOH, I doubt that
any one color scheme would be good for everyone.

---
~Randy
