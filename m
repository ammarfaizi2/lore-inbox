Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280032AbRKOFSn>; Thu, 15 Nov 2001 00:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280743AbRKOFSd>; Thu, 15 Nov 2001 00:18:33 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:26244
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S280032AbRKOFSX>; Thu, 15 Nov 2001 00:18:23 -0500
Date: Thu, 15 Nov 2001 00:16:59 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: CML2 1.8.6 is available -- bug list is cleared
Message-ID: <20011115001659.A9067@thyrsus.com>
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

The latest version is always available at http://www.tuxedo.org/~esr/cml2/

Release 1.8.6: Wed Nov 14 16:58:03 EST 2001
	* Fixed three logic bugs reported by Frederic Gobry, David Kamholz,
	  and Danni Junglas.  These mainly affected rollback when a variable 
	  is unset; sometimes this wasn't being done properly.

This release resolves all known logic bugs and rulebase problems.  The
only things left on the to-do list are convenience features and some minor
improvements in the test/coverage tools.  This code is now officially ready for
the 2.5 fork.

Special thanks go to David Kamholz and David Relson, both of whom have turned
in particularly high-quality bug reports recently.  With collaborators like
these, debugging is almost a pleasure!
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

.. a government and its agents are under no general duty to 
provide public services, such as police protection, to any 
particular individual citizen...
        -- Warren v. District of Columbia, 444 A.2d 1 (D.C. App.181)
