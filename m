Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932618AbVKBH0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932618AbVKBH0E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 02:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932621AbVKBH0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 02:26:01 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:36004 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932618AbVKBH0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 02:26:00 -0500
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
Subject: GIT 0.99.9b
cc: linux-kernel@vger.kernel.org, hpa@zytor.com
Date: Tue, 01 Nov 2005 23:25:59 -0800
Message-ID: <7vbr13y0hk.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The second maintenance release of 0.99.9 series is found at the
usual place.  0.99.9a was purely to work around RPM build
issues; this one contains all the good changes in the master
branch -- mostly documentation updates, with some cvsimport
fixes from Martin.

The workaround for building RPMs has not changed since 0.99.9a,
mainly because I haven't heard back if it was good enough for
kernel.org consumption, or otherwise what changes are needed.

Note that package split we discussed earlier is not something I
consider "needed"; it is more like "nice to have before 1.0".  I
am hoping 0.99.9b to hit kernel.org machines soon, so people do
not have to be bitten by 0.99.8f glitches as reported for the
last couple of days.

That is, provided if the RPM workaround in 0.99.9a and this one
is good enough to produce an installable package, of course.

