Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287295AbRL3A3N>; Sat, 29 Dec 2001 19:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287294AbRL3A3E>; Sat, 29 Dec 2001 19:29:04 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:33255
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S287292AbRL3A2r>; Sat, 29 Dec 2001 19:28:47 -0500
Date: Sat, 29 Dec 2001 19:13:28 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: CNL2-1.9.17 is available.
Message-ID: <20011229191328.A10391@thyrsus.com>
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

Release 1.9.17: Sat Dec 29 19:08:06 EST 2001
	* Minor rulebase fixes from lkml.
	* Fixed the last reported of Richard Todd's edge cases.
	* Nailed a lurking compiler bug that prevented < and > from being
	  handled properly.
	* James Mayer's fix for trit comparison.

The bug queue is empty.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Sometimes it is said that man cannot be trusted with the government
of himself.  Can he, then, be trusted with the government of others?
	-- Thomas Jefferson, in his 1801 inaugural address
