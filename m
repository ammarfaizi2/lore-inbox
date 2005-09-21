Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbVIUK7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbVIUK7n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 06:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbVIUK7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 06:59:43 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:13776 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750814AbVIUK7m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 06:59:42 -0400
Date: Wed, 21 Sep 2005 16:31:22 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>, davem@davemloft.net,
       anil.s.keshavamurthy@intel.com, ananth@in.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Updating maintainers list with the kprobes maintainers
Message-ID: <20050921110122.GB5130@in.ibm.com>
Reply-To: prasanna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch updates the maintainers list with kprobes maintainers.

Signed-of-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>


---

 linux-2.6.14-rc2-prasanna/MAINTAINERS |   12 ++++++++++++
 1 files changed, 12 insertions(+)

diff -puN MAINTAINERS~kprobes-maintainers MAINTAINERS
--- linux-2.6.14-rc2/MAINTAINERS~kprobes-maintainers	2005-09-21 16:26:00.276108128 +0530
+++ linux-2.6.14-rc2-prasanna/MAINTAINERS	2005-09-21 16:26:00.284106912 +0530
@@ -1404,6 +1404,18 @@ L:	linux-kernel@vger.kernel.org
 L:	fastboot@osdl.org
 S:	Maintained
 
+KPROBES
+P:	Prasanna S Panchamukhi
+M:	prasanna@in.ibm.com
+P:	Ananth N Mavinakayanahalli
+M:	ananth@in.ibm.com
+P:	Anil S Keshavamurthy
+M:	anil.s.keshavamurthy@intel.com
+P:	David S. Miller
+M:	davem@davemloft.net
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+
 LANMEDIA WAN CARD DRIVER
 P:	Andrew Stanley-Jones
 M:	asj@lanmedia.com

_
-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
