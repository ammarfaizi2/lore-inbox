Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131151AbRCRGz6>; Sun, 18 Mar 2001 01:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131152AbRCRGzs>; Sun, 18 Mar 2001 01:55:48 -0500
Received: from snark.tuxedo.org ([207.106.50.26]:25349 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S131151AbRCRGzd>;
	Sun, 18 Mar 2001 01:55:33 -0500
Date: Sun, 18 Mar 2001 01:58:21 -0500
Message-Id: <200103180658.f2I6wLH17136@snark.thyrsus.com>
From: "Eric S. Raymond" <esr@snark.thyrsus.com>
To: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: CML2 0.9.4 is available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest version is always available at http://www.tuxedo.org/~esr/cml2/

Release 0.9.4: Sun Mar 18 01:48:12 EST 2001
	* Move to hand-rolled LL parser for increased compilation speed.
	* Compile numbers as numbers (solves Giacomo's 0.9.3 bug).

The compilation-speed improvement is pretty dramatic -- factor of two.
As a happy side effect, this change cuts the line count of CML2 by
about 500 lines; the whole system is now 4874 lines of Python code.

The rules file in this version is current to 2.4.2.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The two pillars of `political correctness' are, 
  a) willful ignorance, and
  b) a steadfast refusal to face the truth
	-- George MacDonald Fraser
