Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279505AbRKMWD0>; Tue, 13 Nov 2001 17:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279509AbRKMWDS>; Tue, 13 Nov 2001 17:03:18 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:54739
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S279505AbRKMWDL>; Tue, 13 Nov 2001 17:03:11 -0500
Date: Tue, 13 Nov 2001 17:50:10 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: CML 1.8.4 is available
Message-ID: <20011113175010.A15716@thyrsus.com>
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

Release 1.8.4: Tue Nov 13 17:31:15 EST 2001
	* Resync with 2.4.15-pre4 (except for SH port).
	* Rulebase corrections from Keith Owens and Colin Slater.
	* DANGEROUS is now a warndepend condition; this means there is a policy
	  symbol DANGEROUS, and any symbol dependent on it will show DANGROUS
	  in its legend.
	* Visibility improvement from Romain BEAUGRAND.
	* Complete coverage check -- CML1 fossil symbols eliminated.
	* Matthieu Verbert's configtrans.py fix.

CML2 is now fully caught up with the CML1 rulebase in the most current
kernel version, with symbol coverage mechanically checked in both directions.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"Those who make peaceful revolution impossible 
will make violent revolution inevitable."
	-- John F. Kennedy
