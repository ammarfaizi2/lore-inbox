Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266473AbTBFLAQ>; Thu, 6 Feb 2003 06:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266535AbTBFLAQ>; Thu, 6 Feb 2003 06:00:16 -0500
Received: from ns.suse.de ([213.95.15.193]:41231 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S266473AbTBFLAP>;
	Thu, 6 Feb 2003 06:00:15 -0500
To: torvalds@transmeta.com (Linus Torvalds)
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5 changeset 1.952.4.2 corrupt in fs/jfs/inode.c
X-Yow: Awright, which one of you hid my PENIS ENVY?
From: Andreas Schwab <schwab@suse.de>
Date: Thu, 06 Feb 2003 12:09:51 +0100
In-Reply-To: <b1s23k$3je$1@penguin.transmeta.com> (torvalds@transmeta.com's
 message of "Wed, 5 Feb 2003 22:09:56 +0000 (UTC)")
Message-ID: <jelm0tis1s.fsf@sykes.suse.de>
User-Agent: Gnus/5.090014 (Oort Gnus v0.14) Emacs/21.3.50 (ia64-suse-linux)
References: <20030205174021.GE19678@dualathlon.random>
	<20030205201055.GL19678@dualathlon.random>
	<20030205203445.GA4467@mars.ravnborg.org>
	<20030205205127.GP19678@dualathlon.random>
	<b1s23k$3je$1@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com (Linus Torvalds) writes:

|> I don't think you can emulate this in CVS easily, since the branch has
|> to be "pre-created" in the CVS repository (when it was HEAD), I don't
|> think you can go back and create a branch "in the past" to graft onto. 

I think with "cvs tag -b -r whatever" you can create a branch on any
point of the CVS history.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
