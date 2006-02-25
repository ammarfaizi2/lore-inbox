Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932696AbWBYMx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932696AbWBYMx2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 07:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932700AbWBYMx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 07:53:28 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:25349 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932696AbWBYMx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 07:53:27 -0500
Date: Sat, 25 Feb 2006 13:53:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@suse.de>
Cc: Johannes Stezenbach <js@linuxtv.org>, Dave Jones <davej@redhat.com>,
       Dmitry Torokhov <dtor_core@ameritech.net>, davej@codemonkey.org.uk,
       Zwane Mwaikambo <zwane@commfireservices.com>,
       Samuel Masham <samuel.masham@gmail.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, cpufreq@lists.linux.org.uk
Subject: Re: Status of X86_P4_CLOCKMOD?
Message-ID: <20060225125326.GJ3674@stusta.de>
References: <20060214152218.GI10701@stusta.de> <20060223204110.GE6213@redhat.com> <20060225015722.GC8132@linuxtv.org> <200602250527.03493.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602250527.03493.ak@suse.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2006 at 05:27:01AM +0100, Andi Kleen wrote:
> On Saturday 25 February 2006 02:57, Johannes Stezenbach wrote:
> > On Thu, Feb 23, 2006, Dave Jones wrote:
> > > On Thu, Feb 23, 2006 at 08:59:37PM +0100, Adrian Bunk wrote:
> > >  > And if the option is mostly useless, what is it good for?
> > > 
> > > It's sometimes useful in cases where the target CPU doesn't have any better
> > > option (Speedstep/Powernow).  The big misconception is that it
> > > somehow saves power & increases battery life. Not so.
> > > All it does is 'not do work so often'.  The upside of this is
> > > that in some situations, we generate less heat this way.
> > 
> > Doesn't less heat imply less power consumption?
> 
> Not in this case no.
>...

Sorry for the dumb question, but how could this work physically?

If a computer produces less heat with the same power consumption, what 
happens with the other energy?

> -Andi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

