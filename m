Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262070AbREPWMr>; Wed, 16 May 2001 18:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262099AbREPWMi>; Wed, 16 May 2001 18:12:38 -0400
Received: from tahoe.in-system.com ([207.70.22.1]:25865 "EHLO
	tahoe.in-system.com") by vger.kernel.org with ESMTP
	id <S262070AbREPWM0>; Wed, 16 May 2001 18:12:26 -0400
Date: Wed, 16 May 2001 16:12:18 -0600
From: Jim Castleberry <jcastle@in-system.com>
To: linux-kernel@vger.kernel.org
Subject: "clock timer configuration lost" on Serverworks chipset
Message-ID: <20010516161218.A28362@osprey.in-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting messages saying "clock timer configuration lost - probably
a VIA686a" from 2.2.19 running on a board using the Serverworks HE
chipset.  Reading the list archives it sounds like this problem has
previously been attributed to a possible bug in the VIA chipset.

According to RedHat's bugzilla database, others have seen it on
Serverworks chipsets, too.  And it sounds like using "noapic" sometimes
makes it go away, which doesn't make much sense to me.

How well has the problem been nailed down?  Could it be that it just
showed up first on VIA and the real cause (and fix) remains to be
discovered?  Or does Serverworks somehow have an identical bug in
their chipset?

jcastle

