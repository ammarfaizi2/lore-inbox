Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265300AbSJaUqE>; Thu, 31 Oct 2002 15:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265303AbSJaUqE>; Thu, 31 Oct 2002 15:46:04 -0500
Received: from excalibur.cc.purdue.edu ([128.210.189.22]:49426 "EHLO
	ibm-ps850.purdueriots.com") by vger.kernel.org with ESMTP
	id <S265300AbSJaUqD>; Thu, 31 Oct 2002 15:46:03 -0500
Date: Thu, 31 Oct 2002 15:54:02 -0500 (EST)
From: Patrick Finnegan <pat@purdueriots.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andreas Herrmann <AHERRMAN@de.ibm.com>, <linux-kernel@vger.kernel.org>,
       <lkcd-devel@lists.sourceforge.net>,
       <lkcd-devel-admin@lists.sourceforge.net>,
       <lkcd-general@lists.sourceforge.net>,
       Rusty Russell <rusty@rustcorp.com.au>,
       "Matt D. Robinson" <yakker@aparity.com>
Subject: Re: [lkcd-devel] Re: What's left over.
In-Reply-To: <Pine.LNX.4.44.0210311239430.2334-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0210311548120.9552-100000@ibm-ps850.purdueriots.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002, Linus Torvalds wrote:

> On Thu, 31 Oct 2002, Andreas Herrmann wrote:
> >
> > A dump mechanism within the kernel is a base for much easier
> > kernel debugging.
> > IMHO, analyzing a dump is much more effective than guessing
> > a kernel bug solely with help of an oops message.
>
> And imnsho, debugging the kernel on a source level is the way to do it.
>
> Which is why it's not going to be me who merges it.

But, LKCD is useful also for tracing crashes back to hardware that causes
it.  It's really hard to find problems in hardware using source code,
since the source code DOENS'T have anything to do with the problems.

Pat
--
Purdue Universtiy ITAP/RCS
Information Technology at Purdue
Research Computing and Storage
http://www-rcd.cc.purdue.edu

http://dilbert.com/comics/dilbert/archive/images/dilbert2040637020924.gif



