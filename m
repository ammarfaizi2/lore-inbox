Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284674AbRLPPrc>; Sun, 16 Dec 2001 10:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284669AbRLPPrW>; Sun, 16 Dec 2001 10:47:22 -0500
Received: from ns.suse.de ([213.95.15.193]:7953 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S284659AbRLPPrQ>;
	Sun, 16 Dec 2001 10:47:16 -0500
Date: Sun, 16 Dec 2001 16:47:15 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: More fun with fsx.
In-Reply-To: <15388.49199.506238.303762@charged.uio.no>
Message-ID: <Pine.LNX.4.33.0112161646210.876-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Dec 2001, Trond Myklebust wrote:

> I get a size error when I don't apply the patch that fixes the
> attribute update race. Can you try with that patch applied? It
> can be found on
>   http://www.fys.uio.no/~trondmy/src/2.4.17/linux-2.4.17-fattr.dif

No change with this applied on client side. Should I bother
recompiling server side with this ?

regards,
Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

