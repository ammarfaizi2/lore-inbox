Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261689AbTBQBcm>; Sun, 16 Feb 2003 20:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262201AbTBQBcm>; Sun, 16 Feb 2003 20:32:42 -0500
Received: from 5-077.ctame701-1.telepar.net.br ([200.193.163.77]:3212 "EHLO
	5-077.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261689AbTBQBcl>; Sun, 16 Feb 2003 20:32:41 -0500
Date: Sun, 16 Feb 2003 22:42:17 -0300 (BRT)
From: Rik van Riel <riel@imladris.surriel.com>
To: Matthew Wilcox <willy@debian.org>
cc: Linus Torvalds <torvalds@transmeta.com>, "" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [RESEND 6] sysctls for PA-RISC
In-Reply-To: <20030216190930.B6290@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.50L.0302162240310.16271-100000@imladris.surriel.com>
References: <20030216190930.B6290@parcelfarce.linux.theplanet.co.uk>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Feb 2003, Matthew Wilcox wrote:

> Can anyone think why Linus isn't applying this patch?

Not a clue, the only thing I can think of is that Linus might
like other people to look at the patch before applying it...

Linus, Matthew's patch only adds some (PA-RISC conditional)
sysctls to the kernel and is otherwise harmless. Safe to apply.

cheers,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>
