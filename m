Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282081AbRLSScY>; Wed, 19 Dec 2001 13:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282062AbRLSScP>; Wed, 19 Dec 2001 13:32:15 -0500
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120]:28867 "EHLO
	albatross.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S282081AbRLSScC>; Wed, 19 Dec 2001 13:32:02 -0500
Content-Type: text/plain; charset=US-ASCII
From: Eli <eli@pflash.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.x WinBookXL mouse & keyboard freeze
Date: Wed, 19 Dec 2001 12:33:07 -0600
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16GlVY-0000sF-00@albatross.prod.itd.earthlink.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

When running any 2.4.x kernel, if gpm is running, touching the mouse ends all 
keyboard input.  Starting X without touching the mouse does the same thing.
The mouse in this case is the built-in trackpad thing common in notebooks.
2.2.x works just fine.

I don't know quite where to start on this... I've tried changing gpm 
configuration, but that doesn't seem to help.
(I'm running RedHat 7.2.)

Any ideas on where I should start looking?

TIA,

Eli  (Please CC me.) 
---------------.
Eli Carter      \
eli(a)pflash.com `-------------------------------------------------------
