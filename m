Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbWHGXbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbWHGXbX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 19:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbWHGXbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 19:31:22 -0400
Received: from cdma-45-249.msk.skylink.ru ([83.217.45.249]:37852 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932402AbWHGXbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 19:31:21 -0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH 0/3] FS_ENET: move to the PAL api
Date: Tue, 08 Aug 2006 03:14:41 +0400
To: Jeff Garzik <jeff@garzik.org>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060807231441.13683.70528.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are patches, that utilize Phy Abstraction Layer API in the fs_enet
Freescale SoC Ethernet driver. Comments gavered from the community addressed,
+ minor fixes and improvements.

--
Sincerely, Vitaly
