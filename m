Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbULBTZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbULBTZG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 14:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbULBTZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 14:25:06 -0500
Received: from adsl-63-194-133-30.dsl.snfc21.pacbell.net ([63.194.133.30]:30337
	"EHLO penngrove.fdns.net") by vger.kernel.org with ESMTP
	id S261723AbULBTZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 14:25:00 -0500
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: re: 2.6.10-rc2 on VAIO laptop and PowerMac 8500/G3
Message-Id: <E1CZwZV-0002DY-00@penngrove.fdns.net>
From: Tovar <tvr@penngrove.fdns.net>
Date: Thu, 02 Dec 2004 11:24:57 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    There have been recent sonypi patches, althought they're fairly
    minor-looking.  But make sure that you're using the latest kernel. 
    2.6.10-rc2 is ancient history ;)

Yeah, i found out 'sonypi' looks pretty good now as of 2.6.10-rc2, about
15 minutes after the posting.  But didn't want to generate excess traffic
until i had something else to post about.  It now seems to handle software
suspend decently, thank you very much(!), and my earlier problems were due 
to obsolete (as of -rc2) work-arounds.  There is still at least one software
suspend issue that i'm aware of, besides firewire, on a built-in USB device
that i've never used.

I'll report again on pending issues when -rc3 comes out, as i have no 
clues which 'bk' patches are stable or otherwise, and don't have time to
find out for myself right now...  I will check specific releases upon
request or recommendation.
				  -- JM
