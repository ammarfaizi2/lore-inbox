Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135176AbRDLM4e>; Thu, 12 Apr 2001 08:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135177AbRDLM4Y>; Thu, 12 Apr 2001 08:56:24 -0400
Received: from d186.as5200.mesatop.com ([208.164.122.186]:56206 "HELO
	gopnik.dom-duraki") by vger.kernel.org with SMTP id <S135176AbRDLM4S>;
	Thu, 12 Apr 2001 08:56:18 -0400
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
Date: Thu, 12 Apr 2001 06:00:24 -0600
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="US-ASCII"
Cc: Aaron Lehmann <aaronl@vitelus.com>,
        Michael Elizabeth Chastain <chastain@cygnus.com>,
        <kbuild-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
To: Dave Jones <davej@suse.de>, <esr@thyrsus.com>
In-Reply-To: <Pine.LNX.4.30.0104121400420.7530-100000@Appserv.suse.de>
In-Reply-To: <Pine.LNX.4.30.0104121400420.7530-100000@Appserv.suse.de>
Subject: Re: [kbuild-devel] Re: CML2 1.0.0 release announcement
MIME-Version: 1.0
Message-Id: <01041206002400.19748@gopnik.dom-duraki>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 April 2001 06:07, Dave Jones wrote:
> On Wed, 11 Apr 2001 esr@thyrsus.com wrote:
> > Unfortunately, I'm fairly sure that finishing gcml would take long
> > enough to render the point moot, because by the time it was done the
> > average Linux machine would have sped up enough for the Python
> > implementation not to be laggy anymore :-).
>
> 'Average' Linux machine is irrelevant. I still have a Sparc IPX
> I occasionally use. I know people using still using 486's as they
> can't afford anything better. Hell, even some of my P5 class machines
> are starting to show their age, but they're still in daily use.
> To say "Screw them, upgrade" is not an option IMO.

Excuse me, but this seems to be something of a red herring.  I've got
a crowd of Pentium-90 and 100 machines at work, and they get new kernels
occasionally, but I haven't built a kernel using that class of machine
in 5 years or so.  I build new kernels using a dual 733 PIII.  Just for
"fun", I built a kernel using a uniprocessor 266 PII a few months ago, but
I have much better things to do with my time.

It would seem to me that if someone is using an older and slower machine
to build a kernel, they are probably doing this somewhat infrequently,
and the longer build process, although more painful for those few users,
should be endurable if it is indeed infrequent.

Keep in mind that making a kernel on a current machine has gone from 
a couple of hours (1992) to two minutes (2001).  Adding seconds or tens 
of seconds at this time on 2001 hardware will seem very moot by the 
time 2.5/2.6 is at the point 2.4.x is now.

If you haven't seen my posts here before, I just joined this list last night.

Steven
