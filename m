Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263154AbTC1V7h>; Fri, 28 Mar 2003 16:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263163AbTC1V7h>; Fri, 28 Mar 2003 16:59:37 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:45484 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S263154AbTC1V7h>; Fri, 28 Mar 2003 16:59:37 -0500
Date: Fri, 28 Mar 2003 22:10:37 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: NICs trading places ?
Message-ID: <20030328221037.GB25846@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just upgraded a box with 2 NICs in it to 2.5.66, and found
that what was eth0 in 2.4 is now eth1, and vice versa.
Is this phenomenon intentional ? documented ?
What caused it to do this ?

The box in question has a DEC Tulip and a 3com 3c905,
but I imagine this would affect any system with >1 NIC
of different vendors/drivers ?

		Dave

