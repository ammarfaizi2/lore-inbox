Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136253AbRD0XeB>; Fri, 27 Apr 2001 19:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136254AbRD0Xdn>; Fri, 27 Apr 2001 19:33:43 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:18450 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S132568AbRD0Xdb>;
	Fri, 27 Apr 2001 19:33:31 -0400
Date: Fri, 27 Apr 2001 19:35:01 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: CML2 1.3.1, aka "I stick my neck out a mile..."
Message-ID: <20010427193501.A9805@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Release 1.3.1: Fri Apr 27 19:02:31 EDT 2001
	* kxref.py can now replace the unmaintained checkhelp.pl,  
	  checkconfig.pl, and checkincludes.pl scripts.

I'm going to stick my neck out a mile and say that I think this is a
stable release.  Doing so, of course, is in reality a clever plan which
ensures that at least three embarrassing bugs will be discovered within
the next 24 hours...

Seriously, I am now out of stuff to do on the CML2 code itself.  The
code now seems to be up to acceptable speed even on slow machines, the
UI feature requests have petered out, and this release seems to be
feature-complete with respect to everything that can be done before
the 2.5 cutover.

There is one 1.3.0 bug report pending from jeff millar, but I have 
not been able to reproduce it with 1.3.1.  I will, of course, continue
to process CML2 bug reports and rulesfile fixes.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"The bearing of arms is the essential medium through which the
individual asserts both his social power and his participation in
politics as a responsible moral being..."
        -- J.G.A. Pocock, describing the beliefs of the founders of the U.S.
