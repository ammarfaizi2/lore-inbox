Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751372AbVILO77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbVILO77 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 10:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbVILO7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 10:59:38 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:25863 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751359AbVILO7Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 10:59:24 -0400
Date: Mon, 12 Sep 2005 10:48:53 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: jgarzik@pobox.com, Jon_Wetzel@Dell.com, john.ronciak@intel.com,
       ganesh.venkatesan@intel.com, cramerj@intel.com,
       jesse.brandeburg@intel.com, ayyappan.veeraiyan@intel.com,
       mchan@broadcom.com, davem@davemloft.net, p_gortmaker@yahoo.com,
       tsbogend@alpha.franken.de, romieu@fr.zoreil.com, shemminger@osdl.org,
       rl@hellgate.ch
Subject: [patch 2.6.13 0/16] implement ETHTOOL_GPERMADDR support for a number of drivers
Message-ID: <09122005104853.31717@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A collection of patches which add support for ETHTOOL_GPERMADDR to
the following drivers: 3c59x, 8139cp, 8139too, b44, bnx2, e1000,
e100, forcedeth, ixgb, ne2k-pci, pcnet32, r8169, skge, sundance,
tg3, via-rhine.

I apologize for all the small patches, but I wanted to trim the cc:
lists appropriately for each driver.
