Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264195AbRFFWKv>; Wed, 6 Jun 2001 18:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264199AbRFFWKl>; Wed, 6 Jun 2001 18:10:41 -0400
Received: from turnover.lancs.ac.uk ([148.88.17.220]:34294 "EHLO
	helium.chromatix.org.uk") by vger.kernel.org with ESMTP
	id <S264195AbRFFWK2>; Wed, 6 Jun 2001 18:10:28 -0400
Message-Id: <l03130314b74459ae92f1@[192.168.239.105]>
In-Reply-To: <5.1.0.14.2.20010606143453.028ed400@ansa.hostings.com>
In-Reply-To: <9fm4t7$412$1@penguin.transmeta.com>
 <3B1D5ADE.7FA50CD0@illusionary.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 6 Jun 2001 23:08:31 +0100
To: android <linux@ansa.hostings.com>, torvalds@transmeta.com (Linus Torvalds)
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: Break 2.4 VM in five easy steps
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I'd be happy to write a new routine in assembly

I sincerely hope you're joking.

It's the algorithm that needs fixing, not the implementation of that
algorithm.  Writing in assembler?  Hope you're proficient at writing in
x86, PPC, 68k, MIPS (several varieties), ARM, SPARC, and whatever other
architectures we support these days.  And you darn well better hope every
other kernel hacker is as proficient as that, to be able to read it.

IOW, no chance.

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)

The key to knowledge is not to rely on people to teach you it.

GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)


