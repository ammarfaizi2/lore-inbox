Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264135AbTEWSyo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 14:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264137AbTEWSyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 14:54:44 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:64516 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S264135AbTEWSyn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 14:54:43 -0400
Date: Fri, 23 May 2003 21:07:48 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Kai Henningsen <kaih@khms.westfalen.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [patch?] truncate and timestamps
Message-ID: <20030523210748.A1018@pclin040.win.tue.nl>
References: <Pine.LNX.4.44.0305221726300.19226-100000@home.transmeta.com> <8mRUVSAXw-B@khms.westfalen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <8mRUVSAXw-B@khms.westfalen.de>; from kaih@khms.westfalen.de on Fri, May 23, 2003 at 08:02:00PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 23, 2003 at 08:02:00PM +0200, Kai Henningsen wrote:

> > On Fri, 23 May 2003 Andries.Brouwer@cwi.nl wrote:
> > >
> > > On the other hand, my question was really a different one:
> > > do we want to follow POSIX, also in the silly requirement
> > > that truncate only sets mtime when the size changes, while
> > > O_TRUNC and ftruncate always set mtime.
> 
> See:
> 
>    http://www.opengroup.org/onlinepubs/007904975/functions/ftruncate.html
> 
> Is it really so hard to look it up that we need to spout FUD instead?

Look up ftruncate, look up truncate, loop up open with O_TRUNC and compare.
You will understand what the discussion is about.


