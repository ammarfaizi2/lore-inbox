Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133040AbRDLBwF>; Wed, 11 Apr 2001 21:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133041AbRDLBv4>; Wed, 11 Apr 2001 21:51:56 -0400
Received: from nat-hdqt.valinux.com ([198.186.202.17]:35626 "EHLO
	golux.thyrsus.com") by vger.kernel.org with ESMTP
	id <S133040AbRDLBvt>; Wed, 11 Apr 2001 21:51:49 -0400
Date: Wed, 11 Apr 2001 21:53:20 -0400
From: esr@thyrsus.com
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: Michael Elizabeth Chastain <chastain@cygnus.com>,
        kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Re: CML2 1.0.0 release announcement
Message-ID: <20010411215320.G9081@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: esr@thyrsus.com, Aaron Lehmann <aaronl@vitelus.com>,
	Michael Elizabeth Chastain <chastain@cygnus.com>,
	kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <200104112056.NAA20872@bosch.cygnus.com> <20010411174609.A8410@thyrsus.com> <20010411180138.A27597@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010411180138.A27597@vitelus.com>; from aaronl@vitelus.com on Wed, Apr 11, 2001 at 06:01:38PM -0700
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Lehmann <aaronl@vitelus.com>:
> Maybe you could kill two birds with one stone by calling 1.0.0 the
> prototype and rewriting it in C.

If I were to become absolutely convinced that I can't get acceptable speed
out of Python, I might do that.  There's a gcml project that tracked the CML2
compiler up to about 0.72 level that might make a decent starting point.

Unfortunately, I'm fairly sure that finishing gcml would take long
enough to render the point moot, because by the time it was done the
average Linux machine would have sped up enough for the Python
implementation not to be laggy anymore :-).

No joke -- *you* try writing a theorem-prover in a language with only
fixed-extent data types.  Go on.  Try it.  I think you will (as Mark
Twain put it about the consequences of teasing a cat) acquire a
valuable education, the facts of which will never grow dim or
doubtful.

I'm pretty sure that tuning the Python implementation (coming up with
faster algorithms, perhaps by reorganizing the data structures to do
more precomputation) will be a more effective use of my time.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"One of the ordinary modes, by which tyrants accomplish their purposes
without resistance, is, by disarming the people, and making it an
offense to keep arms."
        -- Constitutional scholar and Supreme Court Justice Joseph Story, 1840
