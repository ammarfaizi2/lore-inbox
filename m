Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276607AbRJNRom>; Sun, 14 Oct 2001 13:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276957AbRJNRod>; Sun, 14 Oct 2001 13:44:33 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:24213 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S276607AbRJNRoQ>; Sun, 14 Oct 2001 13:44:16 -0400
Date: Sun, 14 Oct 2001 20:44:34 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mount --bind and -o [re: nosuid/noexec/nodev handling]
Message-ID: <20011014204434.S22640@niksula.cs.hut.fi>
In-Reply-To: <20011014192258.R1074@niksula.cs.hut.fi> <Pine.GSO.4.21.0110141226130.6026-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0110141226130.6026-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sun, Oct 14, 2001 at 12:29:58PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 14, 2001 at 12:29:58PM -0400, you [Alexander Viro] claimed:
> 
> 
> What version of mount(8)?  

mount-2.11g

> Or, better yet, how about strace -e trace=mount,umount of the whole
> thing?

Sure, if only I can reproduce it. It seems it's not that easy, since I've
just about tried everything I can think of.


-- v --

v@iki.fi
