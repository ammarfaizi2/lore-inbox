Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264903AbUGOBxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264903AbUGOBxz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 21:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265041AbUGOBxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 21:53:54 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:22211 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S264903AbUGOBxx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 21:53:53 -0400
Date: Thu, 15 Jul 2004 02:53:52 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: linux-kernel@vger.kernel.org
Subject: headsup: [drm] in -mm tree at the moment..
Message-ID: <Pine.LNX.4.58.0407150250230.6536@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The DRM that is currently in the -mm tree is an attempt to use proper
Linux PCI device handling, the code is from the DRM CVS where it has lived
for about 3 months, it fallsback to the old style probing if the
framebuffer is loaded for the card,

If anyone has any issues that they haven't seen before particularly people
with multiple DRI supported cards, or multi-head DRI supported cards, let
me know...

It won't be pushed to Linus for a while until I'm happy with it ...

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

