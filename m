Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286564AbRLUU6I>; Fri, 21 Dec 2001 15:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286563AbRLUU56>; Fri, 21 Dec 2001 15:57:58 -0500
Received: from weta.f00f.org ([203.167.249.89]:58820 "EHLO weta.f00f.org")
	by vger.kernel.org with ESMTP id <S286568AbRLUU5t>;
	Fri, 21 Dec 2001 15:57:49 -0500
Date: Sat, 22 Dec 2001 10:00:17 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Rik van Riel <riel@conectiva.com.br>, "Eric S. Raymond" <esr@thyrsus.com>,
        David Garfield <garfield@irving.iisd.sra.com>,
        Linux Anonymous List <linux-kernel@vger.kernel.org>
Subject: Re: Configure.help editorial policy
Message-ID: <20011221210017.GB32465@weta.f00f.org>
In-Reply-To: <20011221153136.G15926@redhat.com> <Pine.LNX.4.33L.0112211835440.28489-100000@duckman.distro.conectiva> <20011221154750.I15926@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011221154750.I15926@redhat.com>
User-Agent: Mutt/1.3.24i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2001 at 03:47:50PM -0500, Benjamin LaHaise wrote:

    On Fri, Dec 21, 2001 at 06:36:22PM -0200, Rik van Riel wrote:

    > Also, a GB of disk space really is 2^10 * 10^6 ...
    >
    > Better make sure we get it consistent ... *runs like hell*

    I always thought they'd like to count the size of disks in bits...
    man, don't you really want on of those new 240Gbit disks?  I hear
    they can pull in a sustained 200Gbit/s on reads!

But what Rik points out shows that right now there is ambiguity
BECAUSE OF LACK OF STANDARDIZATION --- because GB is vague at the very
best, disk manufactures get to claim nice marketing numbers.

As for bits/second sort of thing, this is common in networking of
course, especially when they talk about raw data rate and ignore
framing overhead and such like.


   --cw
