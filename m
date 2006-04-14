Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964945AbWDNPFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964945AbWDNPFu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 11:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964995AbWDNPFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 11:05:50 -0400
Received: from sccimhc91.asp.att.net ([63.240.76.165]:51445 "EHLO
	sccimhc91.asp.att.net") by vger.kernel.org with ESMTP
	id S964945AbWDNPFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 11:05:49 -0400
From: Steve Snyder <swsnyder@insightbb.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Where to call L2 cache enabling code from?
Date: Fri, 14 Apr 2006 11:05:43 -0400
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604141105.43216.swsnyder@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a machine in which the BIOS does not enable the Pentium3's L2 cache 
at boot time.  At what point in the kernel init process can/should I call 
the code to enable the cache?

Thanks.
