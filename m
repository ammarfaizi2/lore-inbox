Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286769AbRL1GZk>; Fri, 28 Dec 2001 01:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286765AbRL1GZa>; Fri, 28 Dec 2001 01:25:30 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:33233
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S286762AbRL1GZT>; Fri, 28 Dec 2001 01:25:19 -0500
Date: Fri, 28 Dec 2001 01:10:34 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: CML2-1.9.16 is available
Message-ID: <20011228011034.A2017@thyrsus.com>
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

Release 1.9.16: Fri Dec 28 01:02:17 EST 2001
	* Rulebase and help sync with 2.4.18-pre1/2.5.2-pre3.
	* More logic fixes by Richard Todd.
	* Split out ISA_CARDS from ISA in the rulebase.

There is now an automatic regression test for the constraint engine; see the
file torture.test in the distribution.  Richard Todd has been doing 
excellent work fixing various edge cases where the engine does fluky things
and nailing them down in regression tests.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

To make inexpensive guns impossible to get is to say that you're
putting a money test on getting a gun.  It's racism in its worst form.
        -- Roy Innis, president of the Congress of Racial Equality (CORE), 1988
