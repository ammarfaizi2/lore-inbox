Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267852AbTB1M3o>; Fri, 28 Feb 2003 07:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267853AbTB1M3o>; Fri, 28 Feb 2003 07:29:44 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:41183 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S267852AbTB1M3n>; Fri, 28 Feb 2003 07:29:43 -0500
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: Replacement for "make SUBDIRS=...." in 2.5.63?
Date: 28 Feb 2003 13:48:52 +0100
Organization: SuSE Labs, Berlin
Message-ID: <87d6lcbmff.fsf@bytesex.org>
References: <200302250633.WAA06979@adam.yggdrasil.com> <Pine.LNX.4.44.0302251039080.13501-100000@chaos.physics.uiowa.edu>
NNTP-Posting-Host: localhost
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Trace: bytesex.org 1046436533 15130 127.0.0.1 (28 Feb 2003 12:48:53 GMT)
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de> writes:

> I hope that clarifies things a bit. As I wrote earlier, I'll come up with 
> a proper and simple way to build external modules once I find the time.

Any idea what to do until this is available?  The "make
SUBDIRS=/dir/outside/kernel/tree modules" approach worked quite well
for a long time, but stopped working now.  Which isn't very nice for
driver hacking.

  Gerd

-- 
Weil die späten Diskussionen nicht mal mehr den Rotwein lohnen.
				-- Wacholder in “Melanie”
