Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281138AbRKTPsO>; Tue, 20 Nov 2001 10:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281139AbRKTPsE>; Tue, 20 Nov 2001 10:48:04 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:17049
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S281138AbRKTPru>; Tue, 20 Nov 2001 10:47:50 -0500
Date: Tue, 20 Nov 2001 10:44:17 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: David Woodhouse <dwmw2@infradead.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Configure.help missing entries list
Message-ID: <20011120104417.A26597@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20011120095018.A25289@thyrsus.com> <25065.1006269007@redhat.com> <20011120101237.A25814@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011120101237.A25814@thyrsus.com>; from esr@thyrsus.com on Tue, Nov 20, 2001 at 10:12:37AM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric S. Raymond <esr@thyrsus.com>:
> David Woodhouse <dwmw2@infradead.org>:
> > You missed three that I sent you before. If you don't like my version of 
> > CONFIG_MEMORY_SET I'm sure you can come up with a new one - but the other 
> > two ought to be acceptable.
> 
> That's odd.  I have all three of these.  I wonder why they showed up in the 
> `missing' list?  I'll look into this...

Got it.  I missed those three because they're not actually used in CML1 
config files yet.  I was using

	scrips/kxref.py -f "a&~h&~x"

to generate the missing report.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

In the absence of any evidence tending to show that possession 
or use of a 'shotgun having a barrel of less than eighteen inches 
in length' at this time has some reasonable relationship to the 
preservation or efficiency of a well regulated militia, we cannot 
say that the Second Amendment guarantees the right to keep and bear 
such an instrument. [...] The Militia comprised all males 
physically capable of acting in concert for the common defense.  
        -- Majority Supreme Court opinion in "U.S. vs. Miller" (1939)
