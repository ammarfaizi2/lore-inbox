Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129598AbRCZWbK>; Mon, 26 Mar 2001 17:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129618AbRCZWa7>; Mon, 26 Mar 2001 17:30:59 -0500
Received: from snark.tuxedo.org ([207.106.50.26]:14345 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S129598AbRCZWar>;
	Mon, 26 Mar 2001 17:30:47 -0500
Date: Mon, 26 Mar 2001 17:33:52 -0500
Message-Id: <200103262233.f2QMXqm21750@snark.thyrsus.com>
From: "Eric S. Raymond" <esr@snark.thyrsus.com>
To: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: CML2 0.9.7 is available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Release 0.9.7: Mon Mar 26 16:55:48 EST 2001
	* Can now configure everything except the CONFIG_-less CRIS symbols.
	* Prefix-stripping for backward compatibility with, e.g. CONFIG_3C515.
	* Resolve all FIXMES, including Andre Hedrick's IDE vendor stuff.

CML2 can now configure symbols with leading numerics, removing the
last remaining CML1 compatibility problem.  Once the CRIS-architecture
symbols are brought into conformance with the CML1 spec, CML2 will
be able to completely configure a stock kernel tree.  All known gaps
in the CML1 translation have been fixed.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The abortion rights and gun control debates are twin aspects of a deeper
question --- does an individual ever have the right to make decisions
that are literally life-or-death?  And if not the individual, who does?
