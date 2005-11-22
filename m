Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbVKVFnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbVKVFnD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 00:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbVKVFnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 00:43:03 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:6615 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S932332AbVKVFnC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 00:43:02 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Bernd Petrovitsch <bernd@firmix.at>
Subject: Re: what is our answer to ZFS?
Date: Mon, 21 Nov 2005 23:42:47 -0600
User-Agent: KMail/1.8
Cc: Tarkan Erimer <tarkane@gmail.com>, linux-kernel@vger.kernel.org,
       Diego Calleja <diegocg@gmail.com>
References: <11b141710511210144h666d2edfi@mail.gmail.com> <200511211252.04217.rob@landley.net> <1132603369.3306.1.camel@gimli.at.home>
In-Reply-To: <1132603369.3306.1.camel@gimli.at.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511212342.47379.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 November 2005 14:02, Bernd Petrovitsch wrote:
> On Mon, 2005-11-21 at 12:52 -0600, Rob Landley wrote:
> [...]
>
> > couple decades from now.  It's also proposing that data compression and
> > checksumming are the filesystem's job.  Hands up anybody who spots
> > conflicting trends here already?  Who thinks the 128 bit requirement came
> > from marketing rather than the engineers?
>
> Without compressing you probably need 256 bits.

I assume this is sarcasm.  Once again assuming you can someday manage to store 
1 bit per electron, it would have a corresponding 2^256 protons*, which would 
weigh (in grams):

> print 2**256/(6.02*(10**23))
1.92345663185e+53

Google for the weight of the earth:
http://www.ecology.com/earth-at-a-glance/earth-at-a-glance-feature/
Earth's Weight (Mass): 5.972 sextillion (1,000 trillion) metric tons.
Yeah, alright, mass...  So that's 5.972*10^18 metric tons, and a metric ton is 
a million grams, so 5.972*10^24 grams...

Google for the mass of the sun says that's 2*10^33 grams.  Still nowhere 
close.

Basically, as far as I can tell, any device capable of storing 2^256 bits 
would collapse into a black hole under its own weight.

By the way, 2^128/avogadro gives 5.65253101198e+14, or 565 million metric 
tons.  For comparison, the empire state building: 
http://www.newyorktransportation.com/info/empirefact2.html
Is 365,000 tons.  (Probably not metric, but you get the idea.)  Assuming I 
haven't screwed up the math, an object capable of storing anywhere near 2^128 
bits (constructed as a single giant molecule) would probably be in the size 
ballpark of new york, london, or tokyo.

2^64 we may actually live to see the end of someday, but it's not guaranteed.  
2^128 becoming relevant in our lifetimes is a touch unlikely.

Rob

* Yeah, I'm glossing over neutrons.  I'm also glossing over the possibility of 
storing more than one bit per electron and other quauntum strangeness.  I 
have no idea how you'd _build_ one of these suckers.  Nobody does yet.  
They're working on it...
