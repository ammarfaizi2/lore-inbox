Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288622AbSBIISW>; Sat, 9 Feb 2002 03:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288623AbSBIISB>; Sat, 9 Feb 2002 03:18:01 -0500
Received: from [203.143.19.4] ([203.143.19.4]:14859 "EHLO kitul.learn.ac.lk")
	by vger.kernel.org with ESMTP id <S288622AbSBIIRv>;
	Sat, 9 Feb 2002 03:17:51 -0500
Date: Sat, 9 Feb 2002 14:16:27 +0600
From: Anuradha Ratnaweera <anuradha@gnu.org>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] kernelconf-0.1.3
Message-ID: <20020209141627.A12477@lklug.pdn.ac.lk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a `there-is-work-going-on' signal ;)

Got the dependency handling somewhat functional.  Unselect "Loadable
module support", and see how it works.  I wonder if this should be
called a `theorem prover'.

Notice that `functional != working' ;)

This release introduces the `j-k-space' configuration in menuconfig,
which means that the kernel can be completely configured using the keys
j (down), k (up) and space (toggle, select etc.).

Symbol files are now in a seperate tarball.

`Apparent' changes in version 0.1.3
  - Dependency handling (menuconfig)
  - Seperate binaries for each type of config
  - Expanding shorhand notations in dependencies
  - Correct handling of empty expressions
  - Correct handling of line numbers in symbol files
  - Values can also be enclosed in single quotes
  - New tag `rules:' to specify generic constraints
  - Code cleanups and restructuring, as usual ;)

	Anuradha

-- 

Debian GNU/Linux (kernel 2.4.16-xfs)

I am not afraid of tomorrow, for I have seen yesterday and I love today.
		-- William Allen White

