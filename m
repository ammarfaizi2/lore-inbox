Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbVAGOCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbVAGOCo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 09:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbVAGOCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 09:02:44 -0500
Received: from [212.20.225.142] ([212.20.225.142]:54590 "EHLO
	orlando.wolfsonmicro.main") by vger.kernel.org with ESMTP
	id S261416AbVAGOCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 09:02:39 -0500
Subject: [PATCH 1/5] WM97xx touch driver AC97 plugin
From: Liam Girdwood <Liam.Girdwood@wolfsonmicro.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Zabolotny <zap@homelink.ru>,
       Ian Molton <spyro@f2s.com>, Vincent Sanders <vince@simtec.co.uk>
Content-Type: text/plain
Message-Id: <1105106557.9143.1001.camel@cearnarfon>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 07 Jan 2005 14:02:37 +0000
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Jan 2005 14:02:38.0515 (UTC) FILETIME=[8BD62830:01C4F4C1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The wm97xx AC97 plugin. This is the driver for the wm9705, wm9712 and
wm9713.

This file is > 40k so it is available here:-

ftp://62.49.7.54/pub/ac97_plugin_wm97xx.diff

Signed-off-by: Andrew Zabolotny <zap@homelink.ru>
Signed-off-by: Ian Molton <spyro@f2s.com>
Signed-off-by: Vincent Sanders <vince@simtec.co.uk>
Signed-off-by: Russell King <rmk@arm.linux.org.uk>
Signed-off-by: Liam Girdwood <liam.girdwood@wolfsonmicro.com>



