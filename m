Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264723AbTFEPrm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 11:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264726AbTFEPrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 11:47:41 -0400
Received: from holomorphy.com ([66.224.33.161]:17337 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264723AbTFEPrl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 11:47:41 -0400
Date: Thu, 5 Jun 2003 09:00:07 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>, davem@redhat.com,
       bcollins@debian.org, tom_gall@vnet.ibm.com, anton@samba.org
Subject: Re: /proc/bus/pci
Message-ID: <20030605160007.GZ8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Albert Cahalan <albert@users.sourceforge.net>,
	linux-kernel <linux-kernel@vger.kernel.org>, davem@redhat.com,
	bcollins@debian.org, tom_gall@vnet.ibm.com, anton@samba.org
References: <1054816598.22103.6151.camel@cube> <Pine.LNX.4.44.0306050847410.9939-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306050847410.9939-100000@home.transmeta.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jun 2003, Albert Cahalan wrote:
>> Some of the IBMers use "phb" instead of "hose" or "domain".

On Thu, Jun 05, 2003 at 08:51:31AM -0700, Linus Torvalds wrote:
> Gods, did they run out of vowels in _that_ part of IBM too?
> Where do they go? Is there somebody at IBM that hoards vowels, and will 
> one day hold the rest of the world hostage? "Mwahahahaa! If you don't buy 
> support from IBM, you can never use the letter 'A' again! Whahahahhhaah!". 
> I can see it now.
> What the _f*ck_ is wrong with just calling it "PCI domain". It's a fine 
> word, and yes, "domain" is used commonly in computer language, but that's 
> a _good_ thing. Everybody immediately understands what it is about.
> There is no goodness to acronyms where you have to be some "insider" to 
> know what the hell it means. That "hose" thing has the same problem: I 
> don't know about anybody else, but to me a "hose" is a logn narrow conduit 
> for water, and a "PCI hose" doesn't much make sense to me.
> A "phb" just makes me go "Whaa?"

I've never seen this; however, I've seen "PCI segment" used in some
Intel docs. I do agree that neither "phb" nor "hose" are particularly
nice nomenclature.

-- wli
