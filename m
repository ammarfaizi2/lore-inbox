Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132569AbRDODpC>; Sat, 14 Apr 2001 23:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132570AbRDODow>; Sat, 14 Apr 2001 23:44:52 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:9223 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S132569AbRDODog>;
	Sat, 14 Apr 2001 23:44:36 -0400
Date: Sat, 14 Apr 2001 23:45:59 -0400
Message-Id: <200104150345.f3F3jxG16241@snark.thyrsus.com>
From: "Eric S. Raymond" <esr@snark.thyrsus.com>
To: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: CML2 1.1.1, wiuth experimental fast mode
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest version is always available at http://www.tuxedo.org/~esr/cml2/

Release 1.1.1: Sat Apr 14 23:41:34 EDT 2001
	* Synchronized with 2.4.4-pre1.
	* Adam Lackorzynski's patch to make install-cml2 do the right thing 
	  with relative installation paths.
	* The old menuconfig shortcut that 'm' in a boolean entry field
	  sets 'y' is now implemented. 
	* Simplified color scheme.
	* Added fast-mode command to suppress side-effect computation 
	  on slow machines.

I'd appreciate it if some of you with slow machines would try running 
with fast mode on and seeing if that addresses the sluggishness.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Never could an increase of comfort or security be a sufficient good to be
bought at the price of liberty.
	-- Hillaire Belloc
