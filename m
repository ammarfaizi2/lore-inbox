Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285496AbRLSUwc>; Wed, 19 Dec 2001 15:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285483AbRLSUwX>; Wed, 19 Dec 2001 15:52:23 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:43596 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S285469AbRLSUwN>; Wed, 19 Dec 2001 15:52:13 -0500
Date: Wed, 19 Dec 2001 21:52:08 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Gergely Nagy <algernon@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17rc2aa1
Message-ID: <20011219215208.U1395@athlon.random>
In-Reply-To: <20011219161610.I1395@athlon.random> <83k7vjdk8j.wl@iluvatar.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <83k7vjdk8j.wl@iluvatar.ath.cx>; from algernon@debian.org on Wed, Dec 19, 2001 at 09:32:12PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2001 at 09:32:12PM +0100, Gergely Nagy wrote:
> > This should fix the last loop deadlocks under VM pressure, if not please
> > let me know.
> > 
> 
> Unfortunately, it doesn't. I'll do a SysRq+T and kysmoops combo as
> soon as I boot into that kernel again (probably later tonight).

perfect, thanks.

Andrea
