Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267711AbUH2LGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267711AbUH2LGo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 07:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267713AbUH2LGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 07:06:44 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:50920 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S267711AbUH2LGn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 07:06:43 -0400
Date: Sun, 29 Aug 2004 12:06:41 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: linux-kernel@vger.kernel.org
Subject: removing the gamma drm..
Message-ID: <Pine.LNX.4.58.0408291202590.11976@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm thinking of two options for removing the gamma drm

1. Submit a Kconfig patch to mark it broken, see if anyone shouts..
2. Submit a patch to nuke it.

We believe it it has no current users, and it probably is broken but no
one knows.. it allows the drm reorg to me an easier job if the gamma
doesn't have to be worried about..

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

