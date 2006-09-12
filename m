Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751404AbWILIzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbWILIzc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 04:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbWILIzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 04:55:32 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:36517 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S1751376AbWILIzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 04:55:31 -0400
Subject: [patch 0/3] Add tsi108 On chip Ethernet device driver support
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Andrew Morton <akpm@osdl.org>, jgarzik <jgarzik@pobox.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1157962200.10526.10.camel@localhost.localdomain>
References: <A0CDBA58F226D911B202000BDBAD46730A1B1410@zch01exm23.fsl.freescale.net>
	 <1157962200.10526.10.camel@localhost.localdomain>
Content-Type: text/plain
Organization: 
Message-Id: <1158051315.14448.91.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 12 Sep 2006 16:55:15 +0800
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Sep 2006 08:55:25.0425 (UTC) FILETIME=[30149610:01C6D649]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that my previous patch was blocked because of the size :-).
This serial of patches add tsi108/9 on chip Ethernet controller support.

1/3 : Config and Makefile modification.
2/3 : Header file
3/3 : C file

Roy

