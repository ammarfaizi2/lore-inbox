Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264962AbTLKSfT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 13:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265113AbTLKSfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 13:35:19 -0500
Received: from out008pub.verizon.net ([206.46.170.108]:62864 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S264962AbTLKSfL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 13:35:11 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Subject: Re: Increasing HZ (patch for HZ > 1000)
Date: Thu, 11 Dec 2003 13:35:08 -0500
User-Agent: KMail/1.5.1
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <1071122742.5149.12.camel@idefix.homelinux.org> <200312111218.35254.gene.heskett@verizon.net> <1316960000.1071164020@[10.10.2.4]>
In-Reply-To: <1316960000.1071164020@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312111335.08729.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [151.205.60.44] at Thu, 11 Dec 2003 12:35:10 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 December 2003 12:33, Martin J. Bligh wrote:
>> Hardware indeed.  I'm a Certified Electronics Technician.  Have
>> someone check all those electrolyric caps in the on-board psu in
>> particular, using a device similar to a "Capacitor Wizard" which
>> measures not the capacity of the cap, but the caps Equivalent
>> Series Resistance (ESR) at 100 kilohertz or more.  Anything over
>> half an ohm should be replaced forthwith.  This assumes of course
>> that your tech in charge of hot solder has the tools to do it
>> correctly.  If not, find one who does have the tools.
>>
>> Many mobos in a period ranging from about 2.5 to 1.5 years ago
>> were built with caps that go defective prematurely due to a bad
>> batch of them from several far eastern cap makers who were fed a
>> bad recipe for the electrolyte in the caps, eg the Ethylene Glycol
>> wasn't near pure enough.
>
>When you say "fed a bad recipe", didn't they actually steal it? Or
>is that just an urban legend?
>
>M.

Well, I *was* trying to be nice<vsg>.  I'd made the assumption that 
the supplier was the one doing the stealing, and that they (the cap 
makers as buyers of this cheaper than usual product) were not 100% 
aware of the problems at the time.  Yes, I've read the story, and the 
history of capacitor failures over the last 2 years does seem to lend 
considerable credance to the story.  When you are a CET, doing 
component level repairs for a living for the last 50 some years, some 
things do get your attention, and poor life of capacitors has long 
since become the single leading failure of things electronic, 
recently by a factor measured in magnitudes over anything else, like 
bad semiconductors.  Thats been the tend for the last 10 years in 
fact.  Poor lubrication of things basicly mechanical like electrical 
switches is now second on the list, with a lot of white space between 
them.

The windshield wiper speed switch in your car being a prime example of 
that 2nd type of failure.  If it hasn't miss-behaved, it will.  Pull 
the knob off the end of the stalk and remove the super sticky syrupy 
grease there and replace it with lubriplate, end of problem, probably 
forever.  Certainly for as long as you'll own it.  Your trivia fact 
for the day :-)

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

