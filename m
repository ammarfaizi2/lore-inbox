Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133118AbRDLMH3>; Thu, 12 Apr 2001 08:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133117AbRDLMHU>; Thu, 12 Apr 2001 08:07:20 -0400
Received: from ns.suse.de ([213.95.15.193]:63501 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S133116AbRDLMHJ>;
	Thu, 12 Apr 2001 08:07:09 -0400
Date: Thu, 12 Apr 2001 14:07:07 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: <esr@thyrsus.com>
Cc: Aaron Lehmann <aaronl@vitelus.com>,
        Michael Elizabeth Chastain <chastain@cygnus.com>,
        <kbuild-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [kbuild-devel] Re: CML2 1.0.0 release announcement
In-Reply-To: <20010411215320.G9081@thyrsus.com>
Message-ID: <Pine.LNX.4.30.0104121400420.7530-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Apr 2001 esr@thyrsus.com wrote:

> Unfortunately, I'm fairly sure that finishing gcml would take long
> enough to render the point moot, because by the time it was done the
> average Linux machine would have sped up enough for the Python
> implementation not to be laggy anymore :-).

'Average' Linux machine is irrelevant. I still have a Sparc IPX
I occasionally use. I know people using still using 486's as they
can't afford anything better. Hell, even some of my P5 class machines
are starting to show their age, but they're still in daily use.
To say "Screw them, upgrade" is not an option IMO.

> I'm pretty sure that tuning the Python implementation (coming up with
> faster algorithms, perhaps by reorganizing the data structures to do
> more precomputation) will be a more effective use of my time.

Well if you can make this run faster, this would kill my main
complaint with CML2.  I'll try out an updated version sometime.

regards,

Davej.

