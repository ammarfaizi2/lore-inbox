Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262295AbRE0VPu>; Sun, 27 May 2001 17:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262290AbRE0VPa>; Sun, 27 May 2001 17:15:30 -0400
Received: from mail.fbab.net ([212.75.83.8]:54539 "HELO mail.fbab.net")
	by vger.kernel.org with SMTP id <S262291AbRE0VP2>;
	Sun, 27 May 2001 17:15:28 -0400
X-Qmail-Scanner-Mail-From: mag@fbab.net via mail.fbab.net
X-Qmail-Scanner-Rcpt-To: andrea@suse.de jgarzik@mandrakesoft.com it@lapavoni.de linux-kernel@vger.kernel.org alan@lxorguk.ukuu.org.uk torvalds@transmeta.com
X-Qmail-Scanner: 0.94 (No viruses found. Processed in 6.633492 secs)
Message-ID: <031201c0e6f2$58eb8cc0$020a0a0a@totalmef>
From: "Magnus Naeslund\(f\)" <mag@fbab.net>
To: "Andrea Arcangeli" <andrea@suse.de>,
        "Jeff Garzik" <jgarzik@mandrakesoft.com>
Cc: "Ingo T. Storm" <it@lapavoni.de>, <linux-kernel@vger.kernel.org>,
        "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
        "Linus Torvalds" <torvalds@transmeta.com>
In-Reply-To: <3B0BFE90.CE148B7@kjist.ac.kr> <20010523210923.A730@athlon.random> <022e01c0e5fc$39ac0cf0$2e2ca8c0@buxtown.de> <20010526193649.B1834@athlon.random> <20010526201442.D1834@athlon.random> <3B10521D.346E5886@mandrakesoft.com> <20010527044924.H1834@athlon.random> <20010527184123.E676@athlon.random> <20010527212256.A5882@athlon.random>
Subject: Re: 2.4.5 does not link on Ruffian (alpha)
Date: Sun, 27 May 2001 23:16:51 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Andrea Arcangeli" <andrea@suse.de>
> On Sun, May 27, 2001 at 06:41:23PM +0200, Andrea Arcangeli wrote:
> > On Sun, May 27, 2001 at 04:49:24AM +0200, Andrea Arcangeli wrote:
> > > caused me to write the posted patch to get all compilations right.
> >
> > The reason I needed that patch is that I was not using 2.4.5aa1 but a
> > corrupted tree (I'm been fooled by an hardlink during developement), it
> > was just two lines away from the real one.
> >
> > So this is the fix for all 2.4.5 based trees (ac1 and aa1 included) to
> > get generic and dp264 compililations right:
>
> woops, the dp264 compilation wasn't right yet, this additional patch is
> needed too.
>

2.4.5aa1 broke on my ruffian, now it works beautifully, now i just gotta
check if it boots :)

Magnus Naeslund

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
 Programmer/Networker [|] Magnus Naeslund
 PGP Key: http://www.genline.nu/mag_pgp.txt
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


