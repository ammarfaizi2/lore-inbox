Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282873AbRLMJQy>; Thu, 13 Dec 2001 04:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282848AbRLMJQp>; Thu, 13 Dec 2001 04:16:45 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:29124
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S281818AbRLMJQg>; Thu, 13 Dec 2001 04:16:36 -0500
Date: Thu, 13 Dec 2001 04:06:37 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: CML2 1.9.8
Message-ID: <20011213040637.A9104@thyrsus.com>
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

Release 1.9.8: Thu Dec 13 03:52:38 EST 2001
	* Rulebase and help sync with 2.4.17-pre8/2.5.1-pre11.
	* Saveability predicate simplified drastically.

This is a point release intended for Keith Owens to test.  He has
reported a bug that different front ends save out different sets of symbols
set to n; all the variants are logically equivalent, so this is strictly
speaking only a cosmetic bug.  This release attempts to fix the problem by
simplifying the code that determines whether a symbol is eligible to be 
saved out.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The people cannot delegate to government the power to do anything
which would be unlawful for them to do themselves.
	-- John Locke, "A Treatise Concerning Civil Government"
