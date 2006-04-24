Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbWDXTQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWDXTQf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 15:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWDXTQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 15:16:35 -0400
Received: from email-out1.iomega.com ([147.178.1.84]:33481 "EHLO
	email-out1.iomega.com") by vger.kernel.org with ESMTP
	id S1751139AbWDXTQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 15:16:35 -0400
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Transfer-Encoding: 7bit
Message-Id: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: linux-kernel@vger.kernel.org
From: Gary Poppitz <poppitzg@iomega.com>
Subject: Compiling C++ modules
Date: Mon, 24 Apr 2006 13:16:26 -0600
X-Mailer: Apple Mail (2.749.3)
X-OriginalArrivalTime: 24 Apr 2006 19:16:34.0225 (UTC) FILETIME=[99C56A10:01C667D3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the task of porting an existing file system to Linux. This  
code is in C++ and I have noticed that the Linux kernel has
made use of C++ keywords and other things that make it incompatible.

I would be most willing to point out the areas that need adjustment  
and supply patch files to be reviewed.

What would be the best procedure to accomplish this?
