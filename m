Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286356AbRLTTqJ>; Thu, 20 Dec 2001 14:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286354AbRLTTpv>; Thu, 20 Dec 2001 14:45:51 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:3210
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S286351AbRLTTpJ>; Thu, 20 Dec 2001 14:45:09 -0500
Date: Thu, 20 Dec 2001 14:32:47 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Configure.help editorial policy
Message-ID: <20011220143247.A19377@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I guess it's a pretty quiet week in kernel-hacker land.  Must be,
otherwise people would have better things to do than argue over KB
vs. KiB.  The alternative would be to conclude that significant
portions of the lkml population prefer flaming to coding, and that
couldn't possibly be the case, could it?

Let me make a couple of things clear:

I am by no means in love with the new abbreviations described at
<http://physics.nist.gov/cuu/Units/binary.html>.  I have the same 
reflexes as the rest of you -- they kind of make me want to gag.

If there is a clear consensus from lkml, I will be happy to back
out this change.  Perhaps this terminological standard does not
meet a real need, perhaps it will be rejected by most engineers and 
deserves to wither on the vine.  It's happened before.

However.  In the *absence* of a clear consensus, I will follow best
practices.  Best practice in editing a technical or standards document
is to (a) avoid ambiguous usages, seek clarity and precision; and (b)
to use, follow and reference international standards.

In fact, the first time David Woodhouse submitted this change, some
months ago, I rejected it.  I have since, reluctantly, concluded
that I was wrong to do so.  So when he re-submitted, I merged in
the patch.

My personal esthetic distaste for the new terminology (gack!  "kibi" 
sounds like something I would feed my cat!) is less important
than following best practices.  I'm hoping it will seem less ugly as it
becomes more familiar.

I don't like my duty much in this instance.  But my duty is clear.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"As to the species of exercise, I advise the gun. While this gives [only]
moderate exercise to the body, it gives boldness, enterprise, and independence
to the mind.  Games played with the ball and others of that nature, are too
violent for the body and stamp no character on the mind. Let your gun,
therefore, be the constant companion to your walks."
        -- Thomas Jefferson, writing to his teenaged nephew.
