Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132281AbRDPVlb>; Mon, 16 Apr 2001 17:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132301AbRDPVlV>; Mon, 16 Apr 2001 17:41:21 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:42509 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S132281AbRDPVlJ>;
	Mon, 16 Apr 2001 17:41:09 -0400
Date: Mon, 16 Apr 2001 17:42:23 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: CML2 1.1.3 is available
Message-ID: <20010416174223.A21689@thyrsus.com>
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

				CML2 NEWS

The latest version is always available at http://www.tuxedo.org/~esr/cml2/

Release 1.1.3: 
	* Freeze color changed from cyan to blue.
	* Tom Rini's network-configuration patches.
	* Better detection of set variables to be colored green.
	* Minor resize and scrolling fixes in menuconfig.
	* Fixed a rather nasty bug involving side-effect computation 
	  that showed up if you set, unset, and reset a symbol in a
	  choices menu.
	* In non-choice menus, select bar is now advanced after [ymn].

Point release -- bug fixes and UI cleanups.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The only purpose for which power can be rightfully exercised over any
member of a civilized community, against his will, is to prevent harm
to others. His own good, either physical or moral, is not a sufficient
warrant
	-- John Stuart Mill, "On Liberty", 1859
