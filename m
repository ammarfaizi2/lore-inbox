Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbVHRHH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbVHRHH1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 03:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbVHRHH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 03:07:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37552 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750770AbVHRHH0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 03:07:26 -0400
Date: Thu, 18 Aug 2005 15:12:50 +0800
From: David Teigland <teigland@redhat.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 1/3] dlm: use configfs
Message-ID: <20050818071250.GE10133@redhat.com>
References: <20050818060750.GA10133@redhat.com> <29495f1d05081723293c2bd337@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29495f1d05081723293c2bd337@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Are you the official maintainer of the DLM subsystem? Could you submit
> a patch to add a MAINTAINERS entry? I was looking for a maintainer to

yes

Signed-off-by: David Teigland <teigland@redhat.com>

diff -urpN a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS	2005-08-17 17:19:23.000000000 +0800
+++ b/MAINTAINERS	2005-08-18 15:08:41.270122528 +0800
@@ -748,6 +748,13 @@ M:	jack@suse.cz
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 
+DLM, DISTRIBUTED LOCK MANAGER
+P:	David Teigland
+M:	teigland@redhat.com
+L:	linux-cluster@redhat.com
+W:	http://sources.redhat.com/cluster
+S:	Maintained
+
 DAVICOM FAST ETHERNET (DMFE) NETWORK DRIVER
 P:	Tobias Ringstrom
 M:	tori@unhappy.mine.nu
