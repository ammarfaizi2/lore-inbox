Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130758AbRBWJvc>; Fri, 23 Feb 2001 04:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131025AbRBWJvW>; Fri, 23 Feb 2001 04:51:22 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:29192 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130832AbRBWJvG>; Fri, 23 Feb 2001 04:51:06 -0500
Date: Thu, 22 Feb 2001 21:15:45 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: root <lkthomas@hkicable.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: need to suggest a good FS:
In-Reply-To: <3A95A94E.E3C84BE4@hkicable.com>
Message-ID: <Pine.LNX.4.33.0102222114340.2548-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Feb 2001, root wrote:

>Date: Fri, 23 Feb 2001 08:05:34 +0800
>From: root <lkthomas@hkicable.com>
>To: linux-kernel@vger.kernel.org
>Content-Type: text/plain; charset=us-ascii
>Subject: need to suggest a good FS:
>
>hey all, trouble again
>
>anyone can suggest some good FS that can install linux?
>exclude reiserfs, ext2, ext3, DOS FAT..etc
>just need non-normal or non-popular FS, any suggestion?

cbmfs?  Might be a bit tight on disk space though.  It would
definitely be non-{normal,popular}.


----------------------------------------------------------------------
    Mike A. Harris  -  Linux advocate  -  Free Software advocate
          This message is copyright 2001, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------
Fun thing to do as root, in the root directory:
chmod -R 666 *
Just as bad as rm -rf *, but more fun.
"The files are all there, but I can't do anything with them!"
And you can't change permissions, since chmod isn't executable either. :-)

