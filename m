Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312119AbSCQU7s>; Sun, 17 Mar 2002 15:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312120AbSCQU7i>; Sun, 17 Mar 2002 15:59:38 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:4100 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S312119AbSCQU7Z>;
	Sun, 17 Mar 2002 15:59:25 -0500
Date: Sun, 17 Mar 2002 14:00:14 -0700
From: yodaiken@fsmlabs.com
To: Kai Henningsen <kaih@khms.westfalen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
Message-ID: <20020317140014.A13867@hq.fsmlabs.com>
In-Reply-To: <E16mMDf-0007JE-00@the-village.bc.nu> <alan@lxorguk.ukuu.org.uk> <20020316143916.A23204@hq.fsmlabs.com> <E16mMDf-0007JE-00@the-village.bc.nu> <20020316161057.A23495@hq.fsmlabs.com> <8L1npIcXw-B@khms.westfalen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <8L1npIcXw-B@khms.westfalen.de>; from kaih@khms.westfalen.de on Sun, Mar 17, 2002 at 04:52:00PM +0200
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2002 at 04:52:00PM +0200, Kai Henningsen wrote:
> yodaiken@fsmlabs.com  wrote on 16.03.02 in <20020316161057.A23495@hq.fsmlabs.com>:
> 
> > On Sat, Mar 16, 2002 at 10:00:07PM +0000, Alan Cox wrote:
> > > > databases, routing tables, and images. Our good friends at Intel
> > > > claim "carrier grade" Linux  needs to run threaded apps
> > > > with 10,000 threads to depose Solaris in telecom - all sharing the
> > > > same monster address space.=20
> > >
> > > Thats intel though. The same people who seem to think that hyperthreading
> > > in the CPU is required for carrier grade work 8)
> >
> > I love the whole sound of "carrier grade" though: Do you use "carrier grade"
> > Linux or just the "recreational boating" version?
> 
> Wrong carrier, though. It's not US Navy carriers (those people use NT,  
> after all, and this was "depose Solaris"), it's carriers like AT&T - phone  

Really? So why are they always talking about that ship SS7 and the 
sonar network - SONET ? I think Alan may have something there about the
carrier pigeon angle, though. Needs more study.

Actually, it makes me think of "as big, manoeuverable, and 
low cost  as an aircraft carrier" although that is certainly unfair.

> companies. And I suspect many of those 10,000 threads are handling one  
> phone conversation each. Or maybe one half of one.
> 
> In fact, that's a problem space I find much more interesting than the  
> military. *These* people need to be robust in peacetime. They can't afford  
> a big showy piece of hardware that breaks down when it's finally needed,  
> because "finally" is a very short-term goal.

But in my, as always ever so humble, opinion, 10,000 threads is a programming
error based on the incorrect Solaris theory that threads were a good
substitute for thinking about scheduling operations. So making Linux
handle 10K threads is not necessarily an appealing idea unless you can
think of some very clever way to do it.
On the other hand, if I just wanted to sell chips, I might think 
differently.



> 
> MfG Kai
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

