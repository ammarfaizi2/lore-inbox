Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261206AbTC3UhI>; Sun, 30 Mar 2003 15:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261223AbTC3UhI>; Sun, 30 Mar 2003 15:37:08 -0500
Received: from smtp01.uc3m.es ([163.117.136.121]:48646 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S261206AbTC3UhI>;
	Sun, 30 Mar 2003 15:37:08 -0500
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200303302048.h2UKmFV13053@oboe.it.uc3m.es>
Subject: Re: [PATCH] ENBD for 2.5.64
In-Reply-To: <20030328111945.GC5147@zaurus.ucw.cz> from Pavel Machek at "Mar
 28, 2003 12:19:45 pm"
To: Pavel Machek <pavel@suse.cz>
Date: Sun, 30 Mar 2003 22:48:15 +0200 (MET DST)
Cc: "Peter T. Breuer" <ptb@it.uc3m.es>,
       Justin Cormack <justin@street-vision.com>,
       linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Pavel Machek wrote:"
> Hi!
> 
> >   9) it drops into a mode where it md5sums both ends and skips writes
> >   of equal blocks, if that's faster. It moves in and out of this mode
> >   automatically. This helps RAID resyncs (2* overspeed is common on
> >   100BT nets, that is 20MB/s.).
> 
> Great way to find md5 collisions, I guess
> :-).

Don't worry, I'm not planning on claiming the Turing medal! Or living for
the lifetime of the universe .. :-(.

Peter
