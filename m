Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966100AbWKODbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966100AbWKODbH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 22:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966068AbWKODbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 22:31:07 -0500
Received: from ra.tuxdriver.com ([70.61.120.52]:20755 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S966020AbWKODbF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 22:31:05 -0500
Date: Tue, 14 Nov 2006 22:10:26 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: madwifi-devel@lists.sourceforge.net, lwn@lwn.net, mcgrof@gmail.com,
       david.kimdon@devicescape.com
Subject: ANNOUNCE: SFLC helps developers assess ar5k (enabling free Atheros HAL)
Message-ID: <20061115031025.GH3451@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is my pleasure to announce that the SFLC [1] has assisted the ar5k
developers in evaluating the development history of Reyk Floeter's
OpenBSD reverse-engineered Atheros HAL, ar5k [2].  SFLC's assessment
leads to the conclusion that free software developers should not be
worried about using/extending ar5k or porting ar5k to other platforms.

In the past there were serious questions raised and even dire warnings
made about ar5k's copyright status.  The purpose of this statement
is to refute those claims and to publicly clarify ar5k's status
to developers.

SFLC has made independent inquiries with the OpenBSD team regarding the
development history of ar5k source.  The responses received provide
a reasonable basis for SFLC to believe that the OpenBSD developers
who worked on ar5k did not misappropriate code, and that the ar5k
implementation is OpenBSD's original copyrighted work.

This announcement should serve to remove the cloud which has prevented
progress towards an in-kernel driver for Atheros hardware.  This should
be of particular interest to those involved with the DadWifi project [3].

I'd like to take this opportunity to thank the folks at the SFLC for
their hard work, and I'd also like to personally thank Luis Rodriguez
for the role he played in coordinating contact between the SFLC and
the community at large.

Thanks!

John

[1] http://www.softwarefreedom.org/
[2] http://team.vantronix.net/ar5k/
[3] http://marc.theaimsgroup.com/?l=linux-netdev&m=116113064513921&w=2
-- 
John W. Linville
linville@tuxdriver.com
