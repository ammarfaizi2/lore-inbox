Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284361AbRLMQ7E>; Thu, 13 Dec 2001 11:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284370AbRLMQ6z>; Thu, 13 Dec 2001 11:58:55 -0500
Received: from ns.suse.de ([213.95.15.193]:22790 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S284361AbRLMQ6s>;
	Thu, 13 Dec 2001 11:58:48 -0500
Date: Thu, 13 Dec 2001 17:58:47 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: __devexit_p() in linux-2.5.1-preX?
In-Reply-To: <20011212.192636.133010681.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0112131755110.28164-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2001, David S. Miller wrote:

> This brings up a more generic issue.  It would really be nice to have
> someone who syncs up 2.5.X with the bug fixes going into the 2.4.x
> series.  It really is needed, and it really is a boring and thankless
> job :-)

Something tells me I'll regret this later, but here goes..
I'll keep an eye on 2.4 pre's and resync with 2.5's as and
when a new one appears in either branch.

http://www.codemonkey.org.uk/patches/2.5/patch-2.5.1pre11-dj1.diff.bz2

o	Merge with 2.4.17pre8
	Drop devfs changes. (Newer version in 2.5)
o	Make ncr53c8xx bio aware.			(me).

regards,
Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

