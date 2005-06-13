Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbVFMCr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVFMCr4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 22:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbVFMCr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 22:47:56 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:50587 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S261328AbVFMCrz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 22:47:55 -0400
Message-ID: <42ACF389.40205@brturbo.com.br>
Date: Sun, 12 Jun 2005 23:46:33 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux and Kernel Video <video4linux-list@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] fixes removal of normal_i2c_range on V4L
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is necessary to correct I2C detect after normal_i2c_range
removal applied by  gregkh-i2c-i2c-address_range_removal.patch at -mm
series.

Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

