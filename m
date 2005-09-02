Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751051AbVIBU4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbVIBU4j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 16:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbVIBU4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 16:56:39 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:60356 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751051AbVIBU4j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 16:56:39 -0400
Subject: [PATCH 00/11] memory hotplug
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 02 Sep 2005 13:56:05 -0700
Message-Id: <1125694565.26605.18.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I made sure these apply to 2.6.13-mm1, just after 

	vm-add-page_state-info-to-per-node-meminfo.patch

But, they should apply anywhere after the ppc64 sparsemem extreme fixes
that went into 2.6.13-mm1.

--

The following series implements memory hot-add for ppc64 and i386.
There are x86_64 and ia64 implementations that will be submitted shortly
as well, through the normal maintainers.  

-- Dave

