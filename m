Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262485AbVGKTkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262485AbVGKTkf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 15:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262494AbVGKTka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 15:40:30 -0400
Received: from mailgw.voltaire.com ([212.143.27.70]:62667 "EHLO
	mailgw.voltaire.com") by vger.kernel.org with ESMTP id S262485AbVGKTia
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 15:38:30 -0400
Subject: [PATCH 0/29v2] InfiniBand core update
From: Hal Rosenstock <halr@voltaire.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Content-Type: text/plain
Organization: 
Message-Id: <1121110249.4389.4984.camel@hal.voltaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Jul 2005 15:30:50 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is version 2 of a patch series to get the Infiniband core up to
date. Aside from bug fixes, the following new functionality is also
introduced: 

	MAD (Management Datagram) support for RMPP
			(Reliable MultiPacket Protocol)
	CM (Communications Manager) support
	User CM support
	User MAD changes for RMPP
	Service Record support in SA query

Thanks.

-- Hal

