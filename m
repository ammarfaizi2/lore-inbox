Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292329AbSCDMVK>; Mon, 4 Mar 2002 07:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292330AbSCDMUu>; Mon, 4 Mar 2002 07:20:50 -0500
Received: from pool-151-204-76-90.delv.east.verizon.net ([151.204.76.90]:58118
	"EHLO trianna.2y.net") by vger.kernel.org with ESMTP
	id <S292329AbSCDMUb>; Mon, 4 Mar 2002 07:20:31 -0500
Date: Mon, 4 Mar 2002 07:20:54 -0500
From: Malcolm Mallardi <magamo@ranka.2y.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.18 vs 2.4.17 DVD video preformance problem?
Message-ID: <20020304072054.A12646@trianna.upcommand.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Heyla folks.  I hit a snag while using 2.4.18 for the first
time the other day.... When I played DVDs under it, there would be a
large amount of 'skips' in comparison to 2.4.17.  I know, not much of a
bug report, as I think the bug may have already been addressed.
	The reason I say this is that my DVD-ROM drive is on the
secondary IDE channel of a PIIX4 chipset.  Under 2.4.17 playback
preformance is nearly perfect.  Could these "PIIX4 slave timing" fixes
that I've been reading about in a few of the newer changelogs be what
I'm looking for?  I'm going to track down one of the newer patches
(probably -pre2-ac1) and try it out and see if that gives better
preformance for me.

--
Malcolm D. Mallardi - Dark Freak At Large
"Captain, we are receiving two-hundred eighty-five THOUSAND hails."
AOL: Nuark  UIN: 11084092 Y!: Magamo Jabber: Nuark@jabber.com
http://ranka.2y.net:3000/~magamo/index.htm
