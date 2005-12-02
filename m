Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbVLBRC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbVLBRC3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 12:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbVLBRC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 12:02:29 -0500
Received: from sccrmhc11.comcast.net ([63.240.77.81]:35033 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750827AbVLBRC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 12:02:28 -0500
From: kernel-stuff@comcast.net (Parag Warudkar)
To: Stelian Pop <stelian@popies.net>,
       Michael Hanselmann <linux-kernel@hansmi.ch>
Cc: debian-powerpc@lists.debian.org,
       linux-kernel <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
       johannes@sipsolutions.net
Subject: Re: PowerBook5,8 - TrackPad update
Date: Fri, 02 Dec 2005 17:02:23 +0000
Message-Id: <120220051702.24733.43907E1E000B191F0000609D220702293300009A9B9CD3040A029D0A05@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Dec 17 2004)
X-Authenticated-Sender: a2VybmVsLXN0dWZmQGNvbWNhc3QubmV0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My original patch is still work in progress and was intended as a starting point if someone was already adept with the trackpad stuff and was willing to help. 
(Basically it was a call for help - nothing for end users ;)

Things that remained to be done -

Either
1) Support for all PowerBooks in one code base (> Feb 2005)
Or
1) Create different versions for each one or two of them

Depending upon whether or not widely varying algorithms are needed for each variety.

2) Major part - reliably working code for finger movement detection for all Oct 2005 PowerBooks (15" itself seems to come with trackpads having entirely different characteristics.) 

3) Possibly Dual Finger Detection for scrolling - this is optional but would be good to have.

I am working on it as time and urges permit and it will speed up only if Johannes doesn't get his PowerBook or the one he gets is 0x0216 !!

Parag



