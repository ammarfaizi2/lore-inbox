Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132176AbRAYXQP>; Thu, 25 Jan 2001 18:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131850AbRAYXQF>; Thu, 25 Jan 2001 18:16:05 -0500
Received: from detroit.gci.com ([205.140.80.57]:10765 "EHLO daytona.gci.com")
	by vger.kernel.org with ESMTP id <S129169AbRAYXP7>;
	Thu, 25 Jan 2001 18:15:59 -0500
Message-ID: <BF9651D8732ED311A61D00105A9CA31503515880@berkeley.gci.com>
From: Leif Sawyer <lsawyer@gci.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Daniel Phillips <phillips@innominate.de>,
        Thunder from the hill <thunder@ngforever.de>, alex@foogod.com
Subject: RE: named streams, extended attributes, and posix
Date: Thu, 25 Jan 2001 14:15:47 -0900
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alex@foogod.com [alex@foogod.com] wrote:
> Here's an idea: streams/etc are reached by appending 
> "/.../xxx" or some such to paths, thus:
>   for streamname on /dir/file, we have "/dir/file/.../streamname" 
>  for a directory /dir/dir, we get /dir/dir/.../streamname" 
>    -- "..." is a special subdirectory of any directories which have 

An interesting point to note here would be that
the directory '...'  has been used for many years to 'hide' things
from un-skilled sysadmins.

In other words, warez ftp sites pop up all over the place, and this
directory name is pretty close to being the number one stash point,
right next to ".. "



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
