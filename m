Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263333AbTBXW5K>; Mon, 24 Feb 2003 17:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263342AbTBXW5J>; Mon, 24 Feb 2003 17:57:09 -0500
Received: from 12-225-92-115.client.attbi.com ([12.225.92.115]:2944 "EHLO
	p3.coop.hom") by vger.kernel.org with ESMTP id <S263333AbTBXW5I>;
	Mon, 24 Feb 2003 17:57:08 -0500
Date: Mon, 24 Feb 2003 15:06:40 -0800
From: Jerry Cooperstein <coop@axian.com>
To: linux-kernel@vger.kernel.org
Subject: Thinkpad Keyboard nuttiness since 2.5.60 with power management
Message-ID: <20030224230640.GA1225@p3.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since 2.5.60 the keyboard on my Thinkpad 600X randomly
autorepeats each stroke multiple times, only when
power management is enabled (either APM or ACPI) and
only when powered up with no AC power.  With AC power
everything is fine, and pulling the plug out has
no effects.

Everything was fine in 2.5.59, and I can't find anything
in the 2.5.59->2.5.60 patch that could have caused this.
Anyone else see this -- or maybe I have a hardware problem
the patch is making visible?

Thanks

======================================================================
 Jerry Cooperstein,  Senior Consultant,  <coop@axian.com>
 Axian, Inc., Software Consulting and Training
 4800 SW Griffith Dr., Ste. 202,  Beaverton, OR  97005 USA
 http://www.axian.com/               
======================================================================

