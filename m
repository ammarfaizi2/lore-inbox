Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274862AbRKFU7G>; Tue, 6 Nov 2001 15:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275734AbRKFU6z>; Tue, 6 Nov 2001 15:58:55 -0500
Received: from mustard.heime.net ([194.234.65.222]:32681 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S274862AbRKFU6g>; Tue, 6 Nov 2001 15:58:36 -0500
Date: Tue, 6 Nov 2001 21:58:28 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: <erik@hensema.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: PROPOSAL: /proc standards (was dot-proc interface [was: /proc
In-Reply-To: <slrn9ugh1g.dld.spamtrap@dexter.hensema.xs4all.nl>
Message-ID: <Pine.LNX.4.30.0111062157050.25683-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >1)  IT SHOULD NOT BE PRETTY.  No tabs to line up columns.  No "progress
> >bars."  No labels except as "proc comments" (see later).  No in-line labelling.
>
> It should not be pretty TO HUMANS. Slight difference. It should be pretty
> to shellscripts and other applications though.
>
> Yes, that means we won't be able to do a 'cat /proc/cpuinfo' anymore in the
> future. Bummer.

What about adding a separate choice in the kernel config to allow for
/hproc (or something) human readable /proc file system?

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

