Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285267AbRLNAAE>; Thu, 13 Dec 2001 19:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285265AbRLMX7y>; Thu, 13 Dec 2001 18:59:54 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:5578
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S285267AbRLMX7r>; Thu, 13 Dec 2001 18:59:47 -0500
Date: Thu, 13 Dec 2001 18:49:36 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: CML2 1.9.9 is available
Message-ID: <20011213184936.A20701@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest version is always available at http://www.tuxedo.org/~esr/cml2/

Release 1.9.9: Thu Dec 13 18:36:26 EST 2001
	* Minor cleanups by Richard Todd.
	* Passed Keith Owens's regression tests against CML1 make oldconfig.

Bug queue is empty.  The code has passed scrutiny and hands-on use by the rest
of the kbuild team.  There's a known rulebase glitch near extra-device handling
of SCSI disks which is not critical and should be a one-line fix by somebody
who knows what is actually going on there.

Things have come together nicely: (a) the code is ready and tested, (b) the rulebase 
needs only trivial cleanups, and (c) the Configure.help file is down to only 14 missing
entries, with 6 of the remaining promised any time now.  It looks like we'll actually
be ready to do a major-number release after 1.9.9.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"America is at that awkward stage.  It's too late to work within the system,
but too early to shoot the bastards."
	-- Claire Wolfe
