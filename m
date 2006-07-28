Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161233AbWG1Sos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161233AbWG1Sos (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 14:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161238AbWG1Sor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 14:44:47 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:20878
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1161233AbWG1Soq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 14:44:46 -0400
Subject: 2.6.18-rc2-mm1 timer int 0 doesn't work
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060727015639.9c89db57.akpm@osdl.org>
References: <20060727015639.9c89db57.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 28 Jul 2006 13:44:36 -0500
Message-Id: <1154112276.3530.3.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.18-rc2-mm1 causes boot to fail early with:
kernel panic: IO_APIC timer interrupt 0 doesn't work

2.6.18-rc2 works.

2.6.18-rc2-mm1 kernel config located at:
http://www.microgate.com/ftp/linux/test/config

syslog from working 2.6.18-rc2 located at:
http://www.microgate.com/ftp/linux/test/syslog

-- 
Paul Fulghum
Microgate Systems, Ltd

