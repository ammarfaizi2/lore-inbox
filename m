Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266689AbUHTMcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266689AbUHTMcI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 08:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266643AbUHTMcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 08:32:08 -0400
Received: from [193.12.224.70] ([193.12.224.70]:3068 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266689AbUHTM37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 08:29:59 -0400
Date: Fri, 20 Aug 2004 14:28:09 +0200
From: Erik Rigtorp <erik@rigtorp.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC] IBM thinkpad Fn+Fx key driver
Message-ID: <20040820122809.GA6167@linux.nu>
Reply-To: erik@rigtorp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've written a driver for some of the extra keys on the thinkpads. The
supported keys are: Fn+ F3, F4, F5, F7, F8, F9, F12. It has been tested on
two diffrent thinkpad x31, but I would like some feedback from testing on
other thinkpads. 

http://rigtorp.se/files/src/thinkpad-acpi.tar.gz

Just download, extract, run make and insmod thinkpad_acpi.ko

/Erik
