Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280813AbRKLPIQ>; Mon, 12 Nov 2001 10:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280816AbRKLPIB>; Mon, 12 Nov 2001 10:08:01 -0500
Received: from [194.234.65.222] ([194.234.65.222]:54978 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S280813AbRKLPHv>; Mon, 12 Nov 2001 10:07:51 -0500
Date: Mon, 12 Nov 2001 16:07:46 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Tux mailing list <tux-list@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Error starting TUX - URGENT - Please help
Message-ID: <Pine.LNX.4.30.0111121601570.28182-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

I'm just started this workshop about testing Tux on Compaq hardware, and
the first thing that happens is that I can't start tux. I hope someone can
help me here, so I can get some testing done... Please...

I'm running linux 2.4.13 with the tux2-full-2.4.13-B0.bz2. When trying to
start tux with the init script in tux 2.1.0, I get the following error
(from dmesg):

TUX: logger thread started.
TUX: thread 0 listens on http://0.0.0.0:80.
TUX: could not start worker thread 1.

Once it actually worked, but after the next reboot, it all fucked up. And
- yes - I did use the same versions of everything.

Thanks for all help
--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

