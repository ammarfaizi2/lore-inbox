Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284833AbRLPVeu>; Sun, 16 Dec 2001 16:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284820AbRLPVea>; Sun, 16 Dec 2001 16:34:30 -0500
Received: from ns.suse.de ([213.95.15.193]:17681 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S283759AbRLPVeW>;
	Sun, 16 Dec 2001 16:34:22 -0500
Date: Sun, 16 Dec 2001 22:34:21 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: More fun with fsx.
In-Reply-To: <15389.4070.855955.296791@charged.uio.no>
Message-ID: <Pine.LNX.4.33.0112162226460.16845-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Dec 2001, Trond Myklebust wrote:

> In that case, I'll need a tcpdump of the point at which the error
> occurs.

Sure no problem... any particular preferred options ?
Want client and server, or just client ?

> I'm unable to produce any problem whatsoever with the new patch
> applied. Certainly not an EIO: that can normally only occur if you are
> using soft mounts (which I assume is not the case?) or if the server
> is screwed up...

This is 'defaults' so, I would guess that is the case looking at the
man page. but, I just tested and its repeatable with hard and soft.

regards,
Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

