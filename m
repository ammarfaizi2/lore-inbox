Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbVBDClu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbVBDClu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 21:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263048AbVBDClt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 21:41:49 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:40115 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S261685AbVBDClb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 21:41:31 -0500
Date: Fri, 4 Feb 2005 03:39:16 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch 0/9] convert IDE device drivers to driver model
Message-ID: <Pine.GSO.4.58.0502040334540.2469@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Patches are against ide-dev-2.6 tree.

#1-8 are IDE fixes/changes needed
#9 is the actual conversion

Bartlomiej
