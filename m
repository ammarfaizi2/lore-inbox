Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135685AbREBRt5>; Wed, 2 May 2001 13:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135686AbREBRti>; Wed, 2 May 2001 13:49:38 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:2579 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S135685AbREBRtS>;
	Wed, 2 May 2001 13:49:18 -0400
Date: Wed, 2 May 2001 13:49:55 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: cate@dplanet.ch
Cc: Peter Samuelson <peter@cadcamlab.org>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Requirement of make oldconfig [was: Re: [kbuild-devel] Re: CML2 1.3.1, aka ...]
Message-ID: <20010502134955.A19257@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>, cate@dplanet.ch,
	Peter Samuelson <peter@cadcamlab.org>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010427193501.A9805@thyrsus.com> <15084.12152.956561.490805@gargle.gargle.HOWL> <20010429183526.B32748@thyrsus.com> <15085.37569.205459.898540@gargle.gargle.HOWL> <20010430133932.B28849@thyrsus.com> <20010430141623.A15821@cadcamlab.org> <200 <3AF00C53.5EEE8E01@math.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AF00C53.5EEE8E01@math.ethz.ch>; from cate@math.ethz.ch on Wed, May 02, 2001 at 03:32:03PM +0200
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giacomo Catenazzi <cate@math.ethz.ch>:
> No. You propmt only one invalid assertion.  After you this prompt
> you continue to validate rules and you will maybe prompt for another
> invalid rules. But these invalid rules are generally infrequent.

I may be having problems with your English.  I don't think I understand this.
 
> It is very unlikely to have constraint on string or on integer.  But
> anyway, where is the problem?  You simple ask the new value of this
> symbol.

The problem is that you're now, in effect, telling me to invent a 
new interactive configurator with different rules than the normal one!

This is a horrible swamp to wander into just to avoid making oldconfig
users fire up vi occasionally.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

  "You have taught us much. Come with us and join the movement."
  "This movement of yours, does it have slogans?" inquired the Chink.
  "Right on!" they cried. And they quoted him some.
  "Your movement, does it have a flag?" asked the Chink.
  "You bet!" and they described their emblem.
  "And does your movement have leaders?"
  "Great leaders."
  "Then shove it up your butts," said the Chink. "I have taught you nothing."

	-- Tom Robbins, "Even Cowgirls Get The Blues"
