Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131121AbQK2CTD>; Tue, 28 Nov 2000 21:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129933AbQK2CSx>; Tue, 28 Nov 2000 21:18:53 -0500
Received: from jalon.able.es ([212.97.163.2]:18321 "EHLO jalon.able.es")
        by vger.kernel.org with ESMTP id <S131121AbQK2CSo>;
        Tue, 28 Nov 2000 21:18:44 -0500
Date: Wed, 29 Nov 2000 02:48:36 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Dan Hollis <goemon@anime.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: XFree 4.0.1/NVIDIA 0.9-5/2.4.0-testX/11 woes [solved]
Message-ID: <20001129024836.A3305@werewolf.able.es>
Reply-To: jamagallon@able.es
In-Reply-To: <20001129021025.A768@werewolf.able.es> <Pine.LNX.4.30.0011281722220.27692-100000@anime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.30.0011281722220.27692-100000@anime.net>; from goemon@anime.net on Wed, Nov 29, 2000 at 02:29:04 +0100
X-Mailer: Balsa 1.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 29 Nov 2000 02:29:04 Dan Hollis wrote:
> On Wed, 29 Nov 2000, J . A . Magallon wrote:
> > On Wed, 29 Nov 2000 01:39:56 Dan Hollis wrote:
> > > Dont forget the nvidia driver is completely SMP broken. As in, trash your
> > > filesystems broken.
> > Not so broken. I use it under SMP 2.2.18-pre23 and works fine.
> 
> Try unreal tournament. Locks up hard during the intro animation. It's been
> listed for months in the nvidia FAQ as a known bug (#6.5.7) with no fix.
> 

Not exactly UT, but I have tried quake3, heretic2, and descent3. And in
the serious group, OpenGL Performer and recently Inventor. I have not
tried to leave q3a in demo mode for two days, but everything else works
fine. And Performer now (v2.4) is SMP'ing.

-- 
Juan Antonio Magallon Lacarta                                 #> cd /pub
mailto:jamagallon@able.es                                     #> more beer

Linux 2.2.18-pre23-vm #3 SMP Wed Nov 22 22:33:53 CET 2000 i686 unknown

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
