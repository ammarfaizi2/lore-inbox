Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262320AbTESD0S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 23:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbTESD0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 23:26:18 -0400
Received: from siaag2ae.compuserve.com ([149.174.40.135]:40635 "EHLO
	siaag2ae.compuserve.com") by vger.kernel.org with ESMTP
	id S262320AbTESD0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 23:26:17 -0400
Date: Sun, 18 May 2003 23:35:43 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: need better I/O scheduler for bulk file serving
To: Felix von Leitner <felix-kernel@fefe.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305182338_MC3-1-397F-D9FD@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felix von Leitner wrote:

> When three people are downloading different images (my server "only" has
> 512 MB RAM, so it can't hold even one of the images in memory) at the
> same time, the bandwidth utilization goes down to 6 MB/sec on my fast
> ethernet NIC.  The hard disk appears to be busy seeking.

  Try RAID1.



