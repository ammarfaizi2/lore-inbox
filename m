Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946326AbWBDHqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946326AbWBDHqa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 02:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946327AbWBDHqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 02:46:30 -0500
Received: from secure.htb.at ([195.69.104.11]:38410 "EHLO pop3.htb.at")
	by vger.kernel.org with ESMTP id S1946326AbWBDHqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 02:46:30 -0500
Date: Sat, 4 Feb 2006 08:46:17 +0100
From: Richard Mittendorfer <delist@gmx.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [aic7xxx] Q: command queue depth limit?
Message-Id: <20060204084617.44aaf3b8.delist@gmx.net>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan *1F5I7i-0004FF-00*ga3AOfJzbJA*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

GoodDay!

Is there some issue in scsi mid-layer with high per device tcq settings
like discribed in Kconfig or is it ok to just be sure not to exceed the
HBA's max?

TIA ritch
