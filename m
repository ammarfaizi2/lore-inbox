Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273137AbRIMKqy>; Thu, 13 Sep 2001 06:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273209AbRIMKqe>; Thu, 13 Sep 2001 06:46:34 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:25862 "EHLO
	mailout05.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S273137AbRIMKq2>; Thu, 13 Sep 2001 06:46:28 -0400
Date: Thu, 13 Sep 2001 12:46:23 +0200
From: Erich Schubert <erich.schubert@mucl.de>
To: linux-kernel@vger.kernel.org
Subject: Compaq Presario Notebook Keyboard "Extensions"
Message-ID: <20010913124623.A22927@erich.xmldesign.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
X-GPG: 4B3A135C 6073 C874 8488 BCDA A6A9  B761 9ED0 78EF 4B3A 135C
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compaq Presario Notebooks (i don't know which ones, at least my Presario
1400 and a friend's Presario 1200) have some additional Keys on the keyboard

These keys apparently do not generate scancodes, i also noticed no
interrupts being generated.
I also tried using "kbd-init", but it didn't help either.

I tried getting information from Compaq, but from their support adress i
got only trashy responses ("we don't support linux on this unix, but you
can try the following [... guide how to connect to the internet with
windows ...]")

Searching with google i found lot's of requests in newsgroups, the
suggestions of using showkeys and xev, but no solution.

Any idea how i might get these keys to work?

I was wondering if there might be an additional set of scancodes, or
some other initialization of the keyboard driver required.
Perhaps someone has contacts to compaq and could get this information
from them. They have some detailed information about their armada
notebook series on their webpage (with detailed listing of non-standard
keycodes etc.), but i could not find analogical information on these
Presario Notebooks.

http://www.compaq.com/support/techpubs/technical_reference_guides/

Thanks for your great work on the Linux kernel.

Greetings,
Erich
