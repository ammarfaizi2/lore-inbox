Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262099AbVATKMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbVATKMz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 05:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbVATKMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 05:12:55 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:15550 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S262099AbVATKMz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 05:12:55 -0500
To: akpm@osdl.org
Subject: [PATCH] Avoiding fragmentation through different allocator
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-Id: <20050120101254.85F00E598@skynet.csn.ul.ie>
Date: Thu, 20 Jan 2005 10:12:54 +0000 (GMT)
From: mel@csn.ul.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

