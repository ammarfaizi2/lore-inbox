Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285874AbRLHIIc>; Sat, 8 Dec 2001 03:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285876AbRLHIIW>; Sat, 8 Dec 2001 03:08:22 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:36745
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S285874AbRLHIIH>; Sat, 8 Dec 2001 03:08:07 -0500
Date: Sat, 8 Dec 2001 02:59:46 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: CML 1.9.5 is available.
Message-ID: <20011208025946.A11772@thyrsus.com>
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

Release 1.9.5: Sat Dec  8 02:47:21 EST 2001
	* Rulebase and help sync with 2.4.17-pre6/2.5.1-pre7.
	* Some edge cases in casting of default expressions are handled better.
	* It is documented that suppressing a symbol suppresses all its 
	  dependents.
	* Correction for Keith Owens's visibility bug.

Keith Owens has an "it would be nice" bug report pending related to suppression
of symbols in the config output.  The queue is otherwise empty.

I'm also looking at the CML1 backport patch.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Morality is always the product of terror; its chains and
strait-waistcoats are fashioned by those who dare not trust others,
because they dare not trust themselves, to walk in liberty.
	-- Aldous Huxley 
