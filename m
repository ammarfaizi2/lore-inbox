Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265212AbTLKTON (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 14:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265215AbTLKTON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 14:14:13 -0500
Received: from out012pub.verizon.net ([206.46.170.137]:63471 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S265212AbTLKTOK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 14:14:10 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: root@chaos.analogic.com, "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: Increasing HZ (patch for HZ > 1000)
Date: Thu, 11 Dec 2003 14:14:07 -0500
User-Agent: KMail/1.5.1
Cc: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <1071122742.5149.12.camel@idefix.homelinux.org> <1316960000.1071164020@[10.10.2.4]> <Pine.LNX.4.53.0312111304380.5754@chaos>
In-Reply-To: <Pine.LNX.4.53.0312111304380.5754@chaos>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312111414.07763.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [151.205.60.44] at Thu, 11 Dec 2003 13:14:09 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 December 2003 13:10, Richard B. Johnson wrote:
>On Thu, 11 Dec 2003, Martin J. Bligh wrote:

No, Gene Heskett wrote this:

>> > Hardware indeed.  I'm a Certified Electronics Technician.  Have
>> > someone check all those electrolyric caps in the on-board psu in
>> > particular, using a device similar to a "Capacitor Wizard" which
>> > measures not the capacity of the cap, but the caps Equivalent
>> > Series Resistance (ESR) at 100 kilohertz or more.  Anything over
>> > half an ohm should be replaced forthwith.  This assumes of
>> > course that your tech in charge of hot solder has the tools to
>> > do it correctly.  If not, find one who does have the tools.
>> >
>> > Many mobos in a period ranging from about 2.5 to 1.5 years ago
>> > were built with caps that go defective prematurely due to a bad
>> > batch of them from several far eastern cap makers who were fed a
>> > bad recipe for the electrolyte in the caps, eg the Ethylene
>> > Glycol wasn't near pure enough.
>>
>> When you say "fed a bad recipe", didn't they actually steal it? Or
>> is that just an urban legend?
>>
>> M.
>
>"Appropriated". Also, it isn't ethylene glycol (that's antifreeze),
>It's potassium hydroxide with an inhibitor. The inhibitor was
> cleverly removed from the recipe and left out to be stolen. As
> expected, it was. Unfortunately, the bad caps didn't damage the
> competing company bad enough to put them out-of-business so the
> whole ploy was a waste of effort. ;^)

I believe that potassium hydroxide, an extremely alkaline chemical, is 
involved with tantalum capacitors only.  For electrolytics, its 
always been, and probably always will be, Ethylene Glycol to replace 
the air in the kraft paper foil seperator, and furnish a high 
dielectric constant, several times that of air.  "Antifreeze", yes 
but without any inhibiters, none, technical pure grade only.  
Resistance in CM3 measured in siemans if you have a meter that goes 
that high.  Most don't.

It doesn't take much on a per cap basis though.  I almost 
single-handedly caused a nationwide shortage of capacitors one winter 
back in the 70's when I needed some pure stuff for the tv transmitter 
I was in charge of at the time.  Seems that during the OPEC oil 
embargo, the only 55 gallon barrel of any kind of ethylene glycol in 
the whole country was a barrel of technical grade, sitting on the 
dock of the Mobil distributor 100 miles down the road in Omaha NE.  I 
probably ran up a 500 dollar phone bill just finding it because I 
started at the refineries on the coasts.

It was either pay the about 10 bucks a gallon for it or go off the 
air.  I paid, or rather the Nebraska ETV commission paid and bought 
that last barrel and KXNE-TV stayed on the air that winter.

It wasn't till late the next summer when the replacement capacitor 
shelf at your local electronics supplier finally started to get some 
dust cover again.  It got pretty bare there for a few months.

Another of your trivia factoids for the day :-)

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

