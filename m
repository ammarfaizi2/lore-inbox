Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129112AbRCWKZk>; Fri, 23 Mar 2001 05:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130470AbRCWKZW>; Fri, 23 Mar 2001 05:25:22 -0500
Received: from snark.tuxedo.org ([207.106.50.26]:32261 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S129112AbRCWKZM>;
	Fri, 23 Mar 2001 05:25:12 -0500
Date: Fri, 23 Mar 2001 05:28:13 -0500
Message-Id: <200103231028.f2NASDo09859@snark.thyrsus.com>
From: "Eric S. Raymond" <esr@snark.thyrsus.com>
To: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: CML2 0.9.6 is available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest version is always available at http://www.tuxedo.org/~esr/cml2/

Release 0.9.6: Fri Mar 23 05:16:05 EST 2001
	* When we return from a submenu in the tk interface, restore
	  the scrolling location in the parent.
	* Disable width resizing in tk front end, it only confuses matters.
	* Hack makefile to use `python2' if it's present.
	* Use the full height of the screen to avoid having scrolling menus.

OK, so this isn't 1.0.0 after all...I felt like doing some UI hacking
on the tkinter stuff.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The men and women who founded our country knew, by experience, that there
are times when the free person's answer to oppressive government has to be
delivered with a bullet.  Thus, the right to bear arms is not just *a*
freedom; it's the mother of all freedoms.  Don't let them disarm you!
