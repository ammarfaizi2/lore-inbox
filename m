Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284890AbRLPXD4>; Sun, 16 Dec 2001 18:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284903AbRLPXDr>; Sun, 16 Dec 2001 18:03:47 -0500
Received: from 217-126-161-163.uc.nombres.ttd.es ([217.126.161.163]:55424 "EHLO
	DervishD.viadomus.com") by vger.kernel.org with ESMTP
	id <S284890AbRLPXDh>; Sun, 16 Dec 2001 18:03:37 -0500
To: raul@viadomus.com, rml@tech9.net
Subject: Re: Is /dev/shm needed?
Cc: linux-kernel@vger.kernel.org
Message-Id: <E16FkV9-00010E-00@DervishD.viadomus.com>
Date: Mon, 17 Dec 2001 00:15:23 +0100
From: =?ISO-8859-1?Q?Ra=FAl?= =?ISO-8859-1?Q?N=FA=F1ez?= de Arenas
	 Coronado <raul@viadomus.com>
Reply-To: =?ISO-8859-1?Q?Ra=FAl?= =?ISO-8859-1?Q?N=FA=F1ez?= de Arenas
	   Coronado <raul@viadomus.com>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hello Robert :)

>It is not needed.  /dev/shm mounted with tmpfs is only needed for POSIX
>shared memory, which is still fairly rare.

    That this means that I can mount more than one 'tmpfs' just like
if it's a *real* filesystem? I wasn't sure, since it's implemented
thru the page cache.

>It is dynamic, so you don't need to specify a size.

    Yes, I knew, I meant the maximum size. I don't want half of the
RAM occupied just by a programming mistake ;)))

    Thanks a lot for your help :)
    Raúl
