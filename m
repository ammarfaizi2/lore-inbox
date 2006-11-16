Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031103AbWKPD62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031103AbWKPD62 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 22:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031106AbWKPD62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 22:58:28 -0500
Received: from rrcs-24-153-218-104.sw.biz.rr.com ([24.153.218.104]:36793 "EHLO
	smtp.opengridcomputing.com") by vger.kernel.org with ESMTP
	id S1031103AbWKPD61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 22:58:27 -0500
From: Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH  00/13] Chelsio T3 RDMA Driver
Date: Wed, 15 Nov 2006 21:58:26 -0600
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Message-Id: <20061116035826.22635.61230.stgit@dell3.ogc.int>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Roland / All:

The following series implements the Chelsio T3 iWARP/RDMA Driver to
be considered for inclusion in 2.6.20.  It depends on the Chelsio
T3 Ethernet Driver which is also under review now for 2.6.20
(http://marc.theaimsgroup.com/?l=linux-netdev&m=116363600816597&w=2).

The patches are against 2.6.19-rc5.

This patch series can also be pulled from:

http://www.opengridcomputing.com/downloads/iw_cxgb3_patches.tar.bz2

The Chelsio T3 Ethernet Driver patch can be pulled from:

http://service.chelsio.com/kernel.org/cxgb3.patch.bz2


Thanks,

Steve.
