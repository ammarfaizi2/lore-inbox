Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132242AbRAQPpz>; Wed, 17 Jan 2001 10:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132396AbRAQPpq>; Wed, 17 Jan 2001 10:45:46 -0500
Received: from jalon.able.es ([212.97.163.2]:12485 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S132242AbRAQPpd>;
	Wed, 17 Jan 2001 10:45:33 -0500
Date: Wed, 17 Jan 2001 16:45:21 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Ishikawa <ishikawa@yk.rim.or.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux not adhering to BIOS Drive boot order?
Message-ID: <20010117164521.A7741@werewolf.able.es>
In-Reply-To: <1355693A51C0D211B55A00105ACCFE64E95191@ATL_MS1> <Pine.LNX.4.21.0101161154580.17397-100000@sol.compendium-tech.com> <20010116153757.A1609@munchkin.spectacle-pond.org> <20010117003205.A711@werewolf.able.es> <3A6569AF.63743C3B@yk.rim.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3A6569AF.63743C3B@yk.rim.or.jp>; from ishikawa@yk.rim.or.jp on Wed, Jan 17, 2001 at 10:45:20 +0100
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2001.01.17 Ishikawa wrote:

> Anyway, I view myself a typical Linux end-user in
> the framework of linux system hacker, linux
> tools developer and the rest (user).
> All I do on my PC is run netscape, read e-mails,
> post news articles, run editor to edit documents,
> and compile a few utilities and such (for
> using openssh).
..
> Granted I probably have more general knowledge of computers,
> (administered and used Data General MV [:-)], DEC, HP, Sun, ...]
> than average users,
> but then I was totally confused about the
> recognition order of SCSI devices under Linux when I
> had the second SCSI adaptor in my PC.
> As a matter of fact, I hit on a dormant bug/feature
> in the SCSI subsystem and was helpless until
> I wrote to Kurt Garloff(DC390(tmscsim) maintainer).
> 

Perhaps I missed the word when I said 'play'. I wanted to say somyhing
like 'play with apache to setup my web server' or 'play with a command
line compiler to do my programs'. Play with soft included in Linux.

The normal user you will find around is people that wants to install the OS
and start doing things with it. SCSI disks are a 'strange' thing for the
average user. They usually see their first SCSI card if buy a SCSI
CD toaster or ZIP and have to install a 1502 or 2906 to drive the recorder.
So they will never have 8 disks in their machines or worry about SCSI
ones because they are expensive. They buy a PC in the store and do
not worry about chipsets or brands (well, now the graphics cards are
changing that, everybody knows what is a GeForce, even if they don't
know the diff between a VIA or a GX).

People coming from mac world (myself) are comfortable between scsi
ids, terminators and so on. Win people are used to master, slave and that.
And in the PC world, SCSI people is the less. So having 3 SCSI cards is
a so advanced matter in a PC (god should have erased the mind of the
designer of the BIOS hell) that I see no reason to tweak lilo or other
soft.


-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.0-ac9 #2 SMP Sun Jan 14 01:46:07 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
