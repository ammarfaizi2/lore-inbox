Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbTLWSo0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 13:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbTLWSo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 13:44:26 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:22221 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S262181AbTLWSoY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 13:44:24 -0500
Date: Tue, 23 Dec 2003 10:45:50 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Linus Torvalds <torvalds@osdl.org>,
       "Giacomo A. Catenazzi" <cate@pixelized.ch>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: SCO's infringing files list
Message-ID: <20031223184550.GE45620@gaz.sfgoth.com>
References: <Pine.LNX.4.58.0312221337010.6868@home.osdl.org> <20031223002641.GD28269@pegasys.ws> <20031223092847.GA3169@deneb.enyo.de> <3FE811E3.6010708@debian.org> <Pine.LNX.4.58.0312230317450.12483@home.osdl.org> <3FE862E7.1@pixelized.ch> <20031223160425.GB45620@gaz.sfgoth.com> <20031223163926.GC45620@gaz.sfgoth.com> <Pine.LNX.4.58.0312230914090.14184@home.osdl.org> <20031223124024.A30934@discworld.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031223124024.A30934@discworld.dyndns.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Charles Cazabon wrote:
> Well, it's been recompressed with gzip, but it's here (among other places):
> ftp://ftp.uni-kassel.de/Mirrors/prep.ai.mit.edu/pub/gnu/glibc/glibc-2.2.2.tar.gz

No, we're looking for the pre-glibc-2 versions.  In the early days of linux
the "libc" version was kept in sync with the gcc it was meant to go with.
So although (IIRC) the early linux libc was forked from GNU's libc it had
its own version numbering.  It wasn't until years later that the big merge
back to glibc happened (1997 or so).

I don't think you'll find any of the old linux libc-2.x.x releases on GNU's
site.

-Mitch
