Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbVA2XjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVA2XjR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 18:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVA2XjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 18:39:17 -0500
Received: from mailgw.aecom.yu.edu ([129.98.1.16]:10165 "EHLO
	mailgw.aecom.yu.edu") by vger.kernel.org with ESMTP id S261603AbVA2XjQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 18:39:16 -0500
Mime-Version: 1.0
Message-Id: <a0620073dbe21cf061aa6@[129.98.90.227]>
Date: Sat, 29 Jan 2005 18:39:33 -0500
To: linux-kernel@vger.kernel.org
From: Maurice Volaski <mvolaski@aecom.yu.edu>
Subject: CONFIG_THERM_PM72 is missing from .config from recent kernels
 (2.6.10, 2.6.11)
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_THERM_PM72 is required for thermal management in at least 
Macs, most notably the PowerMac G5. Without it, the computer will run 
its fans at the max and is very loud.

It's missing from .config in at least a few releases of recent 
kernels (2.6.10, 2.6.11).

Does anyone know why?
-- 

Maurice Volaski, mvolaski@aecom.yu.edu
Computing Support, Rose F. Kennedy Center
Albert Einstein College of Medicine of Yeshiva University
