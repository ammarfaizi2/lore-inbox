Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283114AbRLOSLU>; Sat, 15 Dec 2001 13:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283234AbRLOSLK>; Sat, 15 Dec 2001 13:11:10 -0500
Received: from ns.suse.de ([213.95.15.193]:52754 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S283114AbRLOSLB>;
	Sat, 15 Dec 2001 13:11:01 -0500
Date: Sat, 15 Dec 2001 19:11:00 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Thorsten Sauter <tsauter@gmx.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Compiling 2.4.16 kernel with sound support
In-Reply-To: <20011215184755.1633ef56.tsauter@gmx.net>
Message-ID: <Pine.LNX.4.33.0112151909120.1425-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Dec 2001, Thorsten Sauter wrote:

> The base distri is the current debian sid (apt update today). Here are some environment infos:
> Distri: Debian Sid (i386)
> GCC Version: 2.95.4
> LD Version: 2.11.92.0.12.3
> Any hints?

Yes, search the kernel archives, or the debian archives.
This has been reported a dozen times or so now.
Downgrade binutils, or enable hotplug support or try .17rc1

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

