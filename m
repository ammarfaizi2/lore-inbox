Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270350AbUJUOB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270350AbUJUOB3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 10:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266613AbUJUNnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 09:43:06 -0400
Received: from mx1.kth.se ([130.237.32.140]:17030 "EHLO mx1.kth.se")
	by vger.kernel.org with ESMTP id S261239AbUJUNlW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 09:41:22 -0400
Subject: Re: [PATCH] ibm-acpi-0.6 - ACPI driver for IBM ThinkPad laptops
From: Erik Rigtorp <rigtorp@kth.se>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 21 Oct 2004 15:41:27 +0200
Message-Id: <1098366087.31374.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

+ *  2004-10-19	0.6	use acpi_bus_register_driver() to claim HKEY device

I see you implemented my suggestion. Code looks fine now, nice work!

-- 
Erik Rigtorp <rigtorp@kth.se>

