Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbTKCSIB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 13:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262152AbTKCSIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 13:08:01 -0500
Received: from harddata.com ([216.123.194.198]:30880 "EHLO mail.harddata.com")
	by vger.kernel.org with ESMTP id S262127AbTKCSH6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 13:07:58 -0500
Subject: 2.6 kernel not loading network module
From: mark <mark@harddata.com>
Reply-To: mark@harddata.com
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Hard Data
Message-Id: <1067882861.1867.4.camel@dynamic-171.harddata.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-1) 
Date: Mon, 03 Nov 2003 11:07:41 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay I have an interesting problem. I have an Athlon64 (KT800 chipset
mb) with an onboard nic. The onboard nic is flaky and doesn't always
appear to be present so I installed a SK9521 and was using that as my
network card. I reboot this morning and the onboard nic reappeared and
claimed to be eth0 so I attempted to make the SK9521 eth1 but I could
not get the module to load on boot.

I disabled the onboard nic and still I cannot get the module to load on
boot as eth0. Any ideas?

-- 
Mark Lane, CET	mailto:mark@harddata.com 
Hard Data Ltd.	http://www.harddata.com 
T: 01-780-456-9771 	F: 01-780-456-9772
11060 - 166 Avenue Edmonton, AB, Canada, T5X 1Y3
--> Ask me about our Excellent 1U Systems! <--

