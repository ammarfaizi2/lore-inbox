Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263585AbUHBVCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263585AbUHBVCi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 17:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263640AbUHBVCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 17:02:38 -0400
Received: from sccimhc92.asp.att.net ([63.240.76.166]:37293 "EHLO
	sccimhc92.asp.att.net") by vger.kernel.org with ESMTP
	id S263585AbUHBVCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 17:02:32 -0400
From: Steve Snyder <swsnyder@insightbb.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: HIGHMEM4G config for 1GB RAM on desktop?
Date: Mon, 2 Aug 2004 16:02:34 -0500
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408021602.34320.swsnyder@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to be a controversy about the use of the CONFIG_HIGHMEM4G  
kernel configuration.  After reading many posts on the subject, I still 
don't know which setting is best for me.

My x86 system has 1.0GB of installed memory and is primarily used as a 
desktop environment.  I don't have any SCSI devices that might require a 
high-memory buffer.  Should I enable the CONFIG_HIGHMEM4G config for this 
environment or not?

Thanks.

