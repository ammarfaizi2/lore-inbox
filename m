Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263893AbUHSIwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbUHSIwq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 04:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264298AbUHSIwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 04:52:43 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:20475 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S264154AbUHSItL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 04:49:11 -0400
Date: Thu, 19 Aug 2004 09:49:03 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: linux-kernel@vger.kernel.org
Subject: gamma drm driver..
Message-ID: <Pine.LNX.4.58.0408190947020.31841@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After a bit of discussion on the dri lists, we have come to the decision
that it is probably necessary to retire the above driver, no dri developer
is currently using the above hardware and the driver is so different from
the others it makes a lot of hacks in the drm needed...

If anyone does actually use this driver and hardware let us know or it'll
be marked as BROKEN soon and then it will actually break :-)

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

