Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278305AbRJMO10>; Sat, 13 Oct 2001 10:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278306AbRJMO1S>; Sat, 13 Oct 2001 10:27:18 -0400
Received: from ns.suse.de ([213.95.15.193]:42247 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S278305AbRJMO07>;
	Sat, 13 Oct 2001 10:26:59 -0400
Date: Sat, 13 Oct 2001 16:27:30 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
        <torvalds@transmeta.com>
Subject: Re: [PATCH] Pentium IV cacheline size.
In-Reply-To: <200110131417.QAA25601@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.30.0110131623440.7753-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Oct 2001, Mikael Pettersson wrote:

> According to the P4 and Xeon optimisation manual (#248966-03), the
> L1 cache has a 64-byte line size and the L2 cache has a 128-byte
> line size. (Page 1-18, Table 1-1.) Perhaps someone just confused

Great, conflicting documentation.
#24547203 (Vol3 : System programming guide) has this to say..
(page 325)
"The cache lines for the L1 and L2 caches in the Pentium 4 processor
 are 64 bytes wide"


regards,

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

