Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286307AbRL0Pdk>; Thu, 27 Dec 2001 10:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286300AbRL0Pda>; Thu, 27 Dec 2001 10:33:30 -0500
Received: from ns.suse.de ([213.95.15.193]:41732 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S286308AbRL0PdS>;
	Thu, 27 Dec 2001 10:33:18 -0500
Date: Thu, 27 Dec 2001 16:33:17 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, <ak@suse.de>
Subject: Re: [PATCH: NEW ARCHITECTURE FOR 2.5] support for NCR voyager 
 343x/345x/4100/51xx architecture
In-Reply-To: <200112271409.fBRE9kR19806@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0112271630100.15250-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Dec 2001, James Bottomley wrote:

> Separation is clearly a better way to go.  I'll see what I can do (and whether
> I can take the visw along too). Where is the x86-64 code?  I haven't seen it
> since 2.4.13-ac8.

In cvs at x86-64.org. (info on website at same address).
Andi hasn't merged any releases newer than 2.4.14, so it's a little
behind, but I'd guess we'll be switching it over to track 2.5 at some
point. Andi?

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

