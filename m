Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284653AbRLPP0u>; Sun, 16 Dec 2001 10:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284656AbRLPP0k>; Sun, 16 Dec 2001 10:26:40 -0500
Received: from ns.suse.de ([213.95.15.193]:18192 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S284653AbRLPP0a>;
	Sun, 16 Dec 2001 10:26:30 -0500
Date: Sun, 16 Dec 2001 16:26:26 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: More fun with fsx.
In-Reply-To: <Pine.LNX.4.33.0112161557070.876-100000@Appserv.suse.de>
Message-ID: <Pine.LNX.4.33.0112161625200.876-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Dec 2001, Dave Jones wrote:

> > > Full log of the failcase is at
> > > http://www.codemonkey.org.uk/cruft/nfs-fsx.txt
> > Which kernel and mount options?
> client 2.4.13-ac5, server 2.4.17rc1, default options, nothing special.
> I'll try to reproduce with a newer kernel on the client.

Yup, it's still there with 2.4.17-rc1 as the client too.
Exact same failure.

regards,
Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

