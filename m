Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964872AbWEZXrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbWEZXrN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 19:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964873AbWEZXrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 19:47:13 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:21728 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964872AbWEZXrN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 19:47:13 -0400
Message-ID: <4477937F.3030802@garzik.org>
Date: Fri, 26 May 2006 19:47:11 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: linux-pci@atrey.karlin.mff.cuni.cz
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>
Subject: Moving pci_test_config_bits
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI, I plan to move pci_test_config_bits() from libata-core.c to the PCI 
layer, where it belongs.

	Jeff


