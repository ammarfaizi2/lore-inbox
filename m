Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129242AbRBGNaI>; Wed, 7 Feb 2001 08:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129245AbRBGN3s>; Wed, 7 Feb 2001 08:29:48 -0500
Received: from r2-pc.dcs.qmw.ac.uk ([138.37.88.145]:46997 "EHLO r2-pc")
	by vger.kernel.org with ESMTP id <S129242AbRBGN3k>;
	Wed, 7 Feb 2001 08:29:40 -0500
Date: Wed, 7 Feb 2001 13:29:04 +0000 (GMT)
From: Matt Bernstein <matt@theBachChoir.org.uk>
To: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: increasing the 512 process limit at run-time?
In-Reply-To: <Pine.LNX.4.32.0102070439520.15577-100000@filesrv1.baby-dragons.com>
Message-ID: <Pine.LNX.4.33.0102071327140.8811-100000@r2-pc>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 04:43 -0800 Mr. James W. Laferriere wrote:

>	Hello Matt ,  At what uptime does one hit this limit ?
>uptime
>  4:40am  up 444 days, 12:58,  1 user,  load average: 0.00, 0.00, 0.00
>uname -a
>Linux filesrv2 2.2.6 #1 SMP Thu Jul 1 20:33:30 PDT 1999 i686 unknown
>
>	Not that that is anything spectacular , just looking for
>	rough idea of uptime before hitting the NR_TASKS limit .

up 244 days,  4:38, 57 users,  load average: 0.03, 0.14, 0.16

Linux version 2.2.16
gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)
#1 SMP Thu Jun 8 09:40:14 BST 2000

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
