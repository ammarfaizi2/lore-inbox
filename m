Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284809AbRLPU74>; Sun, 16 Dec 2001 15:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284816AbRLPU7q>; Sun, 16 Dec 2001 15:59:46 -0500
Received: from ns.suse.de ([213.95.15.193]:44047 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S284809AbRLPU7h>;
	Sun, 16 Dec 2001 15:59:37 -0500
Date: Sun, 16 Dec 2001 21:59:29 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: More fun with fsx.
In-Reply-To: <15388.60557.527680.468341@charged.uio.no>
Message-ID: <Pine.LNX.4.33.0112162154080.16845-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Dec 2001, Trond Myklebust wrote:

> I found the bug. It's a pretty ugly race...

Well, you found _a_ bug perhaps, but not this one..
Still repeatedly fails in exactly the same part with
your second patch applied instead.

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

