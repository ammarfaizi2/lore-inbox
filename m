Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273028AbRIOUeV>; Sat, 15 Sep 2001 16:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271665AbRIOUeL>; Sat, 15 Sep 2001 16:34:11 -0400
Received: from purgatory.fdf.net ([209.245.242.218]:60684 "HELO
	purgatory.fdf.net") by vger.kernel.org with SMTP id <S273028AbRIOUd5>;
	Sat, 15 Sep 2001 16:33:57 -0400
Message-ID: <20010915203418.18081.qmail@purgatory.fdf.net>
From: "Dustin Marquess" <jailbird@alcatraz.fdf.net>
Date: Sat, 15 Sep 2001 15:34:18 -0500 (CDT)
To: Tom Vier <tmv5@home.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: PATCH - Software RAID Autodetection for OSF partitions
In-Reply-To: <20010915152319.A17296@zero>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	DOHT! And I'm sure your code was probably a lot cleaner too :)

	That's actually a real good question.. I have a Tru64 v5.1 box
here I can check on...  I'll see what I can find..

	-Dustin

On Sat, 15 Sep 2001, Tom Vier wrote:

> i sent alan a patch for the same thing awhile ago, but he wanted to make
> sure 0xfd isn't used as a type by osf/1.
>
> On Sun, Sep 09, 2001 at 04:44:04AM -0500, Dustin Marquess wrote:
> > Here's a quick patch that I wrote-up for 2.4.10-pre5 (should work with
> > other 2.4.x kernels too), so that the OSF partition code should
> > auto-detect partitions with a fstype of 0xFD (software RAID).
>
>

