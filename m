Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261353AbTC3P2A>; Sun, 30 Mar 2003 10:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261357AbTC3P2A>; Sun, 30 Mar 2003 10:28:00 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:47548 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S261353AbTC3P2A>;
	Sun, 30 Mar 2003 10:28:00 -0500
Date: Sun, 30 Mar 2003 17:39:14 +0200 (MEST)
Message-Id: <200303301539.h2UFdE0q012872@harpo.it.uu.se>
From: mikpe@csd.uu.se
To: felipe_alfaro@linuxmail.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5: Can't unmount fs after using NFS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Mar 2003 17:03:07 +0200, Felipe Alfaro Solana wrote:
>Since I started testing 2.5 on my NFS server, I'm having problems
>unmounting filesystems that were exported by NFS (of course, before
>trying to unmount, I stopped NFS):

I reported the same problem around 2.5.60 or so.
Sadly, it's still present in 2.5.66.

(RH8.0 user-space, nfs stopped with /etc/rc.d/init.d/nfs stop,
exported ext2 partition remains non-umountable.)

/Mikael
