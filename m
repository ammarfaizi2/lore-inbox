Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284001AbRLAITL>; Sat, 1 Dec 2001 03:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284004AbRLAITB>; Sat, 1 Dec 2001 03:19:01 -0500
Received: from 217-126-161-163.uc.nombres.ttd.es ([217.126.161.163]:58788 "EHLO
	DervishD.viadomus.com") by vger.kernel.org with ESMTP
	id <S284001AbRLAISx>; Sat, 1 Dec 2001 03:18:53 -0500
To: aia21@cus.cam.ac.uk, torvalds@transmeta.com
Subject: Re: [PATCH] Enhancement of /proc/partitions output (2.5.1-pre5)
Cc: linux-kernel@vger.kernel.org
Message-Id: <E16A5XI-0005Lr-00@DervishD.viadomus.com>
Date: Sat, 1 Dec 2001 09:30:12 +0100
From: =?ISO-8859-1?Q?Ra=FAl?= =?ISO-8859-1?Q?N=FA=F1ez?= de Arenas
	 Coronado <dervishd@jazzfree.com>
Reply-To: =?ISO-8859-1?Q?Ra=FAl?= =?ISO-8859-1?Q?N=FA=F1ez?= de Arenas
	   Coronado <dervishd@jazzfree.com>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hello Anton :)

>Please consider below patch which adds the starting sector and number of
>sectors to /proc/partitions.

    This is a *great* idea. I was wondering why this information is
not included by default :)))

    I have a somewhat 'special' partition scheme and that information
is vital for me. Thanks a lot for the patch. I hope that Marcello
accepts it for 2.4.17...

    Raúl
