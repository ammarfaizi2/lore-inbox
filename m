Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266373AbUGUAUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266373AbUGUAUY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 20:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266378AbUGUAUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 20:20:24 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:31908 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266373AbUGUAUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 20:20:21 -0400
Subject: 2.6.8-rc2: 'Invalid MAC address' error with via-rhine driver
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1090369207.841.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 20 Jul 2004 20:20:17 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the following error trying to load the via-rhine module with
kernel 2.6.8-rc2.  I did not get this error with 2.6.8-rc1-mm1.

Jul 20 20:11:13 mindpipe kernel: via-rhine.c:v1.10-LK1.1.20-2.6 May-23-2004 Written by Donald Becker
Jul 20 20:11:13 mindpipe kernel: Invalid MAC address for card #0
Jul 20 20:11:13 mindpipe kernel: via-rhine: probe of 0000:00:12.0 failed with error -5

Lee

