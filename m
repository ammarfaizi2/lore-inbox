Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbVEALZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbVEALZs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 07:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbVEALZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 07:25:48 -0400
Received: from plc14-173.linzag.net ([83.164.14.173]:12009 "EHLO
	tuxworld.homelinux.org") by vger.kernel.org with ESMTP
	id S261599AbVEALZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 07:25:45 -0400
To: linux-kernel@vger.kernel.org
Subject: pci-ide pdc20262 large drives and dma
Date: Sun, 01 May 2005 13:28:01 +0200
From: "Macskasi Csaba" <bitumen@tuxworld.homelinux.org>
Content-Type: text/plain; format=flowed; delsp=yes; charset=us-ascii
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <op.sp3gszci1dbb99@localhost.localdomain>
User-Agent: Opera M2/8.0 (Linux, build 1095)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi List!

I am relative sure that I found an annoing bug in the pdc202xx_old driver.  
The problems are officially solved, but there are still those DMA-problems  
with the pdc20262 and drives >40 gb.
Are you aware of that? I am at will to test anything you suggest...
Please CC me to any responses.

Best wishes,
Macskasi Csaba
-- 
bitumen@tuxworld.homelinux.org
http://tuxworld.homelinux.org
