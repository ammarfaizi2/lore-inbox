Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265773AbUGEMZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265773AbUGEMZz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 08:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265923AbUGEMZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 08:25:55 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:39859 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S265773AbUGEMZx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 08:25:53 -0400
Date: Mon, 5 Jul 2004 13:25:51 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [bk pull] some drm typos and whitespace...
Message-ID: <Pine.LNX.4.58.0407051322510.26169@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

This is a minor set of changes, I'm going to commit a bigger set after you
take these but I'll let them go via Andrews tree first...

Please do a

	bk pull bk://drm.bkbits.net/drm-2.6

This will update the following files:

 drivers/char/drm/Kconfig        |    2 +-
 drivers/char/drm/radeon.h       |    2 +-
 drivers/char/drm/radeon_state.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

through these ChangeSets:

<airlied@starflyer.(none)> (04/07/05 1.1787)
   whitespace cleanup in radeon.h

<airlied@starflyer.(none)> (04/07/05 1.1786)
   typo in radeon_state.c

<airlied@starflyer.(none)> (04/07/05 1.1785)
   typo..


