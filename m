Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267743AbRHBSjC>; Thu, 2 Aug 2001 14:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267977AbRHBSiw>; Thu, 2 Aug 2001 14:38:52 -0400
Received: from femail16.sdc1.sfba.home.com ([24.0.95.143]:38065 "EHLO
	femail16.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S267743AbRHBSir>; Thu, 2 Aug 2001 14:38:47 -0400
Date: Thu, 2 Aug 2001 14:41:24 -0400 (EDT)
From: Garett Spencley <gspen@home.com>
X-X-Sender: <gspen@localhost.localdomain>
To: daniel sheltraw <l5gibson@hotmail.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: filesystem problem
In-Reply-To: <F83srxPx83BcTbnoRiC000098a9@hotmail.com>
Message-ID: <Pine.LNX.4.33L2.0108021439580.28140-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Checking root filesystem /dev/hda5 contains a file system with errors,
>    check forced.
> /dev/hda5
> Unattached inode 198516
>
> /dev/hda5: UNEXPECTED INCONSISTENCY; RUN fsck MANUALLY. (ie., without
>         -a or -p options)
>
> Can someone please tell me how to use fsck to fix this
> filesystem problem? Also if you know of a better place to
> post such questions (kernel development list hardly seems
> appropriate) would you please tell me where.

# fsck /dev/hda5

Visit www.kernelnewbies.org for a place to go for these kinds of
questions. It's an irc channel with people that can help out with these
kinds of problems.

-- 
Garett Spencley

I encourage you to encrypt e-mail sent to me using PGP
My public key is available on PGP key servers (http://keyservers.net)
Key fingerprint: 8062 1A46 9719 C929 578C BB4E 7799 EC1A AB12 D3B9

