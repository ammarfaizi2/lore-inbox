Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288086AbSBKL22>; Mon, 11 Feb 2002 06:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288117AbSBKL2T>; Mon, 11 Feb 2002 06:28:19 -0500
Received: from [194.234.65.222] ([194.234.65.222]:29158 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S288086AbSBKL2J>; Mon, 11 Feb 2002 06:28:09 -0500
Date: Mon, 11 Feb 2002 12:28:07 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: <linux-kernel@vger.kernel.org>
Subject: paching 2.5.4 to -pre6???
Message-ID: <Pine.LNX.4.30.0202111222240.27823-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all

Is there something wrong with the -pre6 patch?

I'm trying to patch up the 2.5.4...

# tar xzf ../packed/k/linux-2.5.4.tar.gz
# cd linux-2.4.5
# zcat ../../packed/k/patch-2.5.4-pre6.gz | patch -p1
patching file CREDITS
Reversed (or previously applied) patch detected!  Assume -R? [n]

and so on... patch -p1 -R gives me some hunks, but generally works ...

What's wrong????

thanks

roy

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

