Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270819AbTHAPwr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 11:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270832AbTHAPwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 11:52:47 -0400
Received: from hardcopy.esd.mun.ca ([134.153.36.129]:24744 "EHLO
	hardcopy.esd.mun.ca") by vger.kernel.org with ESMTP id S270819AbTHAPwq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 11:52:46 -0400
From: Stephen Anthony <stephena@users.sourceforge.net>
To: linux-kernel@vger.kernel.org
Subject: What's the timeslice size for kernel 2.6.0-test2, IA32?
Date: Fri, 1 Aug 2003 13:21:45 -0230
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308011321.45183.stephena@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't been able to find this information anywhere.  I know HZ was 
increased to 1000, but was the timeslice decreased to 1 ms (from 10 ms) 
as well?

Steve
