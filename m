Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274456AbRJABzE>; Sun, 30 Sep 2001 21:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274454AbRJAByy>; Sun, 30 Sep 2001 21:54:54 -0400
Received: from ASYNC8-CS2.NET.CS.CMU.EDU ([128.2.188.152]:3334 "EHLO
	mentor.odyssey.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S274469AbRJAByn>; Sun, 30 Sep 2001 21:54:43 -0400
Date: Sun, 30 Sep 2001 21:29:37 -0400
To: "M. Edward Borasky" <znmeb@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] New Anti-Terrorism Law makes "hacking" punishable by life in prison
Message-ID: <20010930212937.A7897@cs.cmu.edu>
Reply-To: /dev/null@mentor.odyssey.cs.cmu.edu
Mail-Followup-To: "M. Edward Borasky" <znmeb@aracnet.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3BB7918E.E74A3BE4@pobox.com> <HBEHIIBBKKNOBLMPKCBBEEOFDNAA.znmeb@aracnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HBEHIIBBKKNOBLMPKCBBEEOFDNAA.znmeb@aracnet.com>
User-Agent: Mutt/1.3.22i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2001 at 03:40:27PM -0700, M. Edward Borasky wrote:
> Here, for your amusement, is a snippet of Perl code:
> 
> $stuff = `uname`;
> if ($stuff =~ /is not recognized as an internal or external command,/ {
> 	# execute malicious Windows code
> }
> else {
> 	# look at the uname stuff and figure out what OS we're running
> 	# then execute OS-specific malicious code
> }
> 
> Do you see what I'm saying?

You run untrusted snippets of perl-code as root?

To return to your original argument,

If a company sells me a car that has a rust-proof guarantee under the
conditions that I keep it garaged 24/7 (similar to the Windows NT C2
rating). And when I take it for a spin someone sprays it with a garden
hose. The car falls apart from the rust. Do I have the right to lock
_any guy with a garden hose_ up in prison because they could cause
irrepairable damage to cars? Or maybe that car shouldn't have left the
factory in the first place.

Any further discussion can go to /dev/null.

Jan

