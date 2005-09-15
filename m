Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030570AbVIOSmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030570AbVIOSmp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 14:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030572AbVIOSmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 14:42:44 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:22710 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id S1030573AbVIOSmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 14:42:44 -0400
From: dth@cistron.nl (Danny ter Haar)
Subject: 2.6.14-rc1-git1.bz: permission problem?
Date: Thu, 15 Sep 2005 18:42:43 +0000 (UTC)
Organization: Cistron
Message-ID: <dgcfb3$c8q$1@news.cistron.nl>
X-Trace: ncc1701.cistron.net 1126809763 12570 62.216.30.70 (15 Sep 2005 18:42:43 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@cistron.nl (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


lftp ftp.kernel.org:/pub/linux/kernel/v2.6/snapshots> get patch-2.6.14-rc1-git1.gz
155962 bytes transferred in 2 seconds (63.8K/s)

lftp ftp.kernel.org:/pub/linux/kernel/v2.6/snapshots> get patch-2.6.14-rc1-git1.bz
get: Access failed: 550 Failed to open file. (patch-2.6.14-rc1-git1.bz)

????


