Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264784AbTFLGzZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 02:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264779AbTFLGxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 02:53:43 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:30341 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264776AbTFLGxg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 02:53:36 -0400
Date: Thu, 12 Jun 2003 12:43:32 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patchset] Fix mishandling of error/exit patchs in 2.5
Message-ID: <20030612071330.GG1146@llm08.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a patchset to fix error/exit paths in 2.5.  This is working off
Alan's list and are forward ports of 2.4 patches.  
Patches will follow for dpt_i2o, jffs, and es1371.

dpt_i2o patch is probably not maintained and doesn't compile with current bk
 -- but that is not because of this fix.  Other patches compile.

Thanks,
Kiran
