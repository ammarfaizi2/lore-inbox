Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbUCDHXN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 02:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbUCDHXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 02:23:13 -0500
Received: from math.ut.ee ([193.40.5.125]:48127 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261535AbUCDHXL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 02:23:11 -0500
Date: Thu, 4 Mar 2004 09:23:07 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: 2.6.3: PnPBIOS hangs with S875WP1 BIOS
Message-ID: <Pine.GSO.4.44.0403040920480.2398-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I run a 2.6.3 kernel on Intel S875WP1 mainboard. When I enable PnPBIOS
in kernel config, the kernel gets general protection fault 0 just after
telling it found PnP BIOS. No backtrace. Disabling PnPBIOS in kernel
works around the problem.

-- 
Meelis Roos (mroos@linux.ee)

