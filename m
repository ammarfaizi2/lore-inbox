Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273661AbRIWWWC>; Sun, 23 Sep 2001 18:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273663AbRIWWVo>; Sun, 23 Sep 2001 18:21:44 -0400
Received: from [216.217.111.75] ([216.217.111.75]:39175 "EHLO synitech.com")
	by vger.kernel.org with ESMTP id <S273661AbRIWWVZ>;
	Sun, 23 Sep 2001 18:21:25 -0400
Message-ID: <32832.65.11.238.48.1001284227.squirrel@mail.synitech.com>
Date: Sun, 23 Sep 2001 18:30:27 -0400 (EDT)
Subject: EMU10k1 Driver
From: "Matthew Koch" <mkoch@synitech.com>
To: linux-kernel@vger.kernel.org
X-Mailer: SquirrelMail (version 1.0.3)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm experiencing issues with the EMU10k1 driver in kernel's 2.4.9 and
2.4.10.  I have an SB Live! X-Gamer card (not 5.1).  It worked perfectly
under 2.4.7.  The mixer is recognized as a SigmaTel card, which is obviously
mistaken.  In addition to that, sound quality is poor and the mixer is not
displaying all the options, specifically digital1 and digital2, the front
and rear outputs.  I'm writing here because the code itself has no contacts
listed as far as I found.  Are there any known fixes to this?  Thank you.

