Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286287AbRLTQnd>; Thu, 20 Dec 2001 11:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286292AbRLTQnU>; Thu, 20 Dec 2001 11:43:20 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:44402 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S286287AbRLTQnM>; Thu, 20 Dec 2001 11:43:12 -0500
Date: Thu, 20 Dec 2001 17:43:01 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Samuel Maftoul <maftoul@esrf.fr>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: NFS > 2Gb
Message-ID: <20011220174301.B1395@athlon.random>
In-Reply-To: <20011220134414.A19648@pcmaftoul.esrf.fr> <shs3d26f1zv.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <shs3d26f1zv.fsf@charged.uio.no>; from trond.myklebust@fys.uio.no on Thu, Dec 20, 2001 at 02:35:32PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2001 at 02:35:32PM +0100, Trond Myklebust wrote:
> >>>>> " " == Samuel Maftoul <maftoul@esrf.fr> writes:
> 
>      > Hello, I didn't find anywhere a clear explication on the
>      > question: Does linux support large file over NFS v3 ?  Does it
> 
> Clear explanation:
> 
> 2.2.x
>   No

btw, 2.2aa yes.

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.2/2.2.20aa1.bz2

Andrea
