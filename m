Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318038AbSGRMcc>; Thu, 18 Jul 2002 08:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318041AbSGRMcc>; Thu, 18 Jul 2002 08:32:32 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:25826 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318038AbSGRMcb>;
	Thu, 18 Jul 2002 08:32:31 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, Art Haas <ahaas@neosoft.com>
Subject: Please drop/back out the trivial named initializer patches 
Date: Thu, 18 Jul 2002 22:27:22 +1000
Message-Id: <20020718123613.42CB94280@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	People complained that Art's patches messed up their pretty
whitespacing: heaven forbid I should disrespect good whitespace.  I
wrote a new script which preserves spaces (even tabs which would be
misaligned by adding the ' =' chars).  Unfortunately, the patch for
the whole kernel is 2MB, touching about 20,000 initializers, so I'm
going to be passing patches through various maintainers in the next
few days.  For the curious, the patches are at the normal location:

http://www.xx.kernel.org/pub/linux/kernel/people/rusty/Initializers

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
