Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129771AbRAZCkv>; Thu, 25 Jan 2001 21:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129834AbRAZCkm>; Thu, 25 Jan 2001 21:40:42 -0500
Received: from smtprelay.abs.adelphia.net ([64.8.20.11]:4776 "EHLO
	smtprelay3.abs.adelphia.net") by vger.kernel.org with ESMTP
	id <S129771AbRAZCkh>; Thu, 25 Jan 2001 21:40:37 -0500
Date: Thu, 25 Jan 2001 21:41:12 -0500 (EST)
From: "Steven N. Hirsch" <shirsch@adelphia.net>
To: Leif Sawyer <lsawyer@gci.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Phillips <phillips@innominate.de>,
        Thunder from the hill <thunder@ngforever.de>, alex@foogod.com
Subject: RE: named streams, extended attributes, and posix
In-Reply-To: <BF9651D8732ED311A61D00105A9CA31503515880@berkeley.gci.com>
Message-ID: <Pine.LNX.4.21.0101252139430.27798-100000@pii.fast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jan 2001, Leif Sawyer wrote:

> alex@foogod.com [alex@foogod.com] wrote:
> > Here's an idea: streams/etc are reached by appending 
> > "/.../xxx" or some such to paths, thus:
> >   for streamname on /dir/file, we have "/dir/file/.../streamname" 
> >  for a directory /dir/dir, we get /dir/dir/.../streamname" 
> >    -- "..." is a special subdirectory of any directories which have 
> 
> An interesting point to note here would be that
> the directory '...'  has been used for many years to 'hide' things
> from un-skilled sysadmins.
> 
> In other words, warez ftp sites pop up all over the place, and this
> directory name is pretty close to being the number one stash point,
> right next to ".. "

It's also the implicit root for the global DFS filesystem namespace (from
Transarc of AFS fame).





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
