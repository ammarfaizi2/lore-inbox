Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751030AbVKKSvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbVKKSvN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 13:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbVKKSvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 13:51:13 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:6068 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751028AbVKKSvM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 13:51:12 -0500
Subject: truncate_inode_pages_range patch to mainline ?
From: Badari Pulavarty <pbadari@us.ibm.com>
To: akpm@osdl.org, reiser@namesys.com
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 11 Nov 2005 10:50:59 -0800
Message-Id: <1131735059.25354.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I would like to find out, what your plans and/or concerns
to push

	reiser4-truncate_inode_pages_range.patch

from your -mm tree to mainline ? I need this for
my madvise(REMOVE) work. And also, I see that 
madvise(REMOVE) is not in -mm2 also. Do you still
have concerns with it ?

Thanks,
Badari

