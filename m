Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261721AbTAVQMX>; Wed, 22 Jan 2003 11:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261742AbTAVQMX>; Wed, 22 Jan 2003 11:12:23 -0500
Received: from tomts25-srv.bellnexxia.net ([209.226.175.188]:42181 "EHLO
	tomts25-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S261721AbTAVQMW>; Wed, 22 Jan 2003 11:12:22 -0500
Date: Wed, 22 Jan 2003 11:20:51 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Sam Ravnborg <sam@ravnborg.org>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: test suite?
In-Reply-To: <20030122155955.GA1219@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0301221120160.2305-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jan 2003, Sam Ravnborg wrote:

> On Wed, Jan 22, 2003 at 08:44:05AM -0500, Robert P. J. Day wrote:
> > 
> >   i've noticed references to "test suites" for kernels, but
> > is there any one-step convenient way to select every possible
> > option for test-compiling a new kernel, just to see if it builds?
> > perhaps an "everything" option?
> 
> Try "make help" some day..
> 
> make allyesconfig
> make allmodconfig
> make allnoconfig <- Opposite of what you ask for.
> 
> 	Sam

thanks for the info.  i assume the condescension was no extra charge.

rday

