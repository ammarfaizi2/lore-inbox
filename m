Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264718AbTFEPi3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 11:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264720AbTFEPi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 11:38:29 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17669 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264718AbTFEPi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 11:38:28 -0400
Date: Thu, 5 Jun 2003 08:51:31 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Albert Cahalan <albert@users.sourceforge.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>, <davem@redhat.com>,
       <bcollins@debian.org>, <wli@holomorphy.com>, <tom_gall@vnet.ibm.com>,
       <anton@samba.org>
Subject: Re: /proc/bus/pci
In-Reply-To: <1054816598.22103.6151.camel@cube>
Message-ID: <Pine.LNX.4.44.0306050847410.9939-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 5 Jun 2003, Albert Cahalan wrote:
> 
> Some of the IBMers use "phb" instead of "hose" or "domain".

Gods, did they run out of vowels in _that_ part of IBM too?

Where do they go? Is there somebody at IBM that hoards vowels, and will 
one day hold the rest of the world hostage? "Mwahahahaa! If you don't buy 
support from IBM, you can never use the letter 'A' again! Whahahahhhaah!". 

I can see it now.


What the _f*ck_ is wrong with just calling it "PCI domain". It's a fine 
word, and yes, "domain" is used commonly in computer language, but that's 
a _good_ thing. Everybody immediately understands what it is about.

There is no goodness to acronyms where you have to be some "insider" to 
know what the hell it means. That "hose" thing has the same problem: I 
don't know about anybody else, but to me a "hose" is a logn narrow conduit 
for water, and a "PCI hose" doesn't much make sense to me.

A "phb" just makes me go "Whaa?"

		Linus

