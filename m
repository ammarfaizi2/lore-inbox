Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbTLWRHx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 12:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbTLWRHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 12:07:51 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:2058 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262041AbTLWRHt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 12:07:49 -0500
Date: Tue, 23 Dec 2003 18:07:42 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Giacomo A. Catenazzi" <cate@debian.org>,
       Florian Weimer <fw@deneb.enyo.de>, jw schultz <jw@pegasys.ws>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: SCO's infringing files list
Message-ID: <20031223170742.GA15049@win.tue.nl>
References: <1072125736.1286.170.camel@duergar> <200312221519.04677.tcfelker@mtco.com> <Pine.LNX.4.58.0312221337010.6868@home.osdl.org> <20031223002641.GD28269@pegasys.ws> <20031223092847.GA3169@deneb.enyo.de> <3FE811E3.6010708@debian.org> <Pine.LNX.4.58.0312230317450.12483@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312230317450.12483@home.osdl.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 23, 2003 at 04:34:41AM -0800, Linus Torvalds wrote:

> The errno change was apparently done on or around July 25, 1992. That's
> the date on the "errno.h" file in the linux-0.97 archive, and it is
> consistent with the above release dates.
> 
> If anybody has newgroup/mailing list archives from around that time, it
> would be very nice to see what that finds..

> Btw: there is some incidental "evidence" that that original 0.97 version
> of <linux/errno.h> is automatically generated: the thing looks to have
> very regular whitespace. It looks like it was generated with
> 
> 	#define\t%s\t\t%2d\t/* %s */
> 
> and then tab-corrected for the symbolic name lengths.
> 
> I've found some archives for linux-activists, but no newsgroup archives 
> going that far back.. Anybody?

Probably we have the same archives. I see the announcement

 From: hlu@yoda.eecs.wsu.edu (H.J. Lu)
 Subject: Re: gcc-2.2.2 patches for linux?
 Date: 19 Jul 1992 15:42:48 GMT

 This is gcc 2.2.2 for Linux. It is on banjo.concert.net under
 /pub/Linux/GCC. Gcc 2.3 will support Linux, according to RMS.
 ...
 The following functions are added to libc.a.
 ...
 4. lots of stuffs added to errno.h and string/errlist.c.

Andries

