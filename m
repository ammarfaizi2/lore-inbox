Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280938AbRKOQdA>; Thu, 15 Nov 2001 11:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280937AbRKOQcu>; Thu, 15 Nov 2001 11:32:50 -0500
Received: from mustard.heime.net ([194.234.65.222]:33178 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S280933AbRKOQcc>; Thu, 15 Nov 2001 11:32:32 -0500
Date: Thu, 15 Nov 2001 17:32:29 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Jens Axboe <axboe@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux i/o tweaking
In-Reply-To: <20011115172246.Z27010@suse.de>
Message-ID: <Pine.LNX.4.30.0111151731280.13922-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could you please try and profile where the time is spent? Boot with
> profile=2, and then do
>
> # readprofile -r
> # do I/O testing
> # readprofile | sort -nr

I will.

However ... Is it normal for a server to max out 2xPIII 1266MHz CPUs by
reading from software RAID-5???

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

