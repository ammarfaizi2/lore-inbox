Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281322AbRK0SmS>; Tue, 27 Nov 2001 13:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282492AbRK0SmM>; Tue, 27 Nov 2001 13:42:12 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:34177
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S281322AbRK0Sly>; Tue, 27 Nov 2001 13:41:54 -0500
Date: Tue, 27 Nov 2001 13:39:44 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: CML2 1.9.1 is available
Message-ID: <20011127133944.A2554@thyrsus.com>
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

Release 1.9.1: Tue Nov 27 13:29:50 EST 2001
	* Rulebase and help sync with 2.4.16/2.5.1-pre1 (except for SH port).
	* APIC rulebase correction by Damian M Gryski <dgryski@uwaterloo.ca>.
	* It is now possible to selectively suppress the emission of derived
	  symbols to the configuration file with an unless...suppress.
	* Improvements to compiler's well-formedness checking.

This folds in a couple of recent feature requests.

Keith Owens has reported a looping bug I can't reproduce -- the bug
log suggests that his CML2 rulebase is mis-installed somehow.  The bug
list is otherwise empty.  The to-do list is empty.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The right of the citizens to keep and bear arms has justly been considered as
the palladium of the liberties of a republic; since it offers a strong moral
check against usurpation and arbitrary power of rulers; and will generally,
even if these are successful in the first instance, enable the people to resist
and triumph over them."
        -- Supreme Court Justice Joseph Story of the John Marshall Court
