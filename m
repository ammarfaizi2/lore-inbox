Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262380AbVDXT51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbVDXT51 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 15:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbVDXT51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 15:57:27 -0400
Received: from mail.kroah.org ([69.55.234.183]:28562 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262380AbVDXT5X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 15:57:23 -0400
Date: Sun, 24 Apr 2005 12:55:55 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: pavel@ucw.cz, drzeus-list@drzeus.cx, torvalds@osdl.org, pasky@ucw.cz,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.12-rc3
Message-ID: <20050424195554.GA2857@kroah.com>
References: <20050422002150.GY7443@pasky.ji.cz> <20050422231839.GC1789@elf.ucw.cz> <Pine.LNX.4.58.0504221718410.2344@ppc970.osdl.org> <20050423111900.GA2226@openzaurus.ucw.cz> <Pine.LNX.4.58.0504230654190.2344@ppc970.osdl.org> <426A7775.60207@drzeus.cx> <20050423220213.GA20519@kroah.com> <20050423222946.GF1884@elf.ucw.cz> <20050423233809.GA21754@kroah.com> <20050424032622.3aef8c9f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050424032622.3aef8c9f.akpm@osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2005 at 03:26:22AM -0700, Andrew Morton wrote:
> Greg KH <greg@kroah.com> wrote:
> > In the patches/ subdir below that one, is a mirror of my quilt patches
> > directory, series file and all.  That way people can still see the
> > individual patches if they want to.
> > 
> > Does this help some?  It's all still under flux as to how this all
> > works, try something and go from there :)
> 
> Yes, it would be nice to have gregkh's patches in -mm as individual patches.

It would?  Ok, that's easy to change.

> Of course, whatever gets done, I'd selfishly prefer that most (or even all)
> subsystem maintainers work the same way and adopt the same work practices.
> 
> I guess it's too early to think about that, but if one maintainer (hint)
> were to develop and document a good methodology and toolset, others might
> quickly follow.

Heh, ok, I can take a hint, I'll work on this this week.  I already have
the "export a series of patches from a git tree that are not in another
git tree" working, so it shouldn't be tough to get the rest in an
"automated" manner.

thanks,

greg k-h
