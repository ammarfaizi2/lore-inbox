Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261347AbRELXYE>; Sat, 12 May 2001 19:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261346AbRELXXy>; Sat, 12 May 2001 19:23:54 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:30154 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261345AbRELXXl>;
	Sat, 12 May 2001 19:23:41 -0400
Date: Sat, 12 May 2001 19:23:38 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: BERECZ Szabolcs <szabi@inf.elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: mount /dev/hdb2 /usr; swapon /dev/hdb2  keeps flooding
In-Reply-To: <Pine.A41.4.31.0105130055400.19270-100000@pandora.inf.elte.hu>
Message-ID: <Pine.GSO.4.21.0105121921550.11973-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 13 May 2001, BERECZ Szabolcs wrote:

> Hi!
> 
> root@kama3:/home/szabi# cat /proc/mounts
> ...
> /dev/hdb2 /usr ext2 rw 0 0
> ...
> root@kama3:/home/szabi# swapon /dev/hdb2

- Doctor, it hurts when I do it!
- Don't do it, then.

Just what behaviour had you expected?

