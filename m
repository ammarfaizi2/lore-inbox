Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286300AbRL0PfK>; Thu, 27 Dec 2001 10:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286315AbRL0PfB>; Thu, 27 Dec 2001 10:35:01 -0500
Received: from ns.suse.de ([213.95.15.193]:46596 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S286311AbRL0Pev>;
	Thu, 27 Dec 2001 10:34:51 -0500
Date: Thu, 27 Dec 2001 16:34:49 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Rik van Riel <riel@conectiva.com.br>, <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH: NEW ARCHITECTURE FOR 2.5] support for NCR voyager 
 343x/345x/4100/51xx architecture
In-Reply-To: <200112271408.fBRE84d19791@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0112271633210.15250-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Dec 2001, James Bottomley wrote:

> I would like to do this.  I didn't do it for the 2.4 series because such a
> patch would have been very difficult to maintain.  I'll see if I can separate
> the VISW code as well.

I did this a while ago (just put the patch at
http://www.codemonkey.org.uk/patches/2.5/small-bits/visws-split.diff)
There's a slightly better version in 2.5.1-dj6 which I'll put up later
today if all goes well.

regards,
Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

