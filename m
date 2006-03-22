Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750872AbWCVGyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbWCVGyO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 01:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750961AbWCVGyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 01:54:14 -0500
Received: from smtp.enter.net ([216.193.128.24]:25094 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1750872AbWCVGyN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 01:54:13 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: xm86 syscall
Date: Wed, 22 Mar 2006 01:54:09 -0500
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603220154.09996.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been looking through the kernel, reading the man pages, studying the 
headers and I still cannot find enough information on the vm86 syscall in 
order to be able to use it in one of my private projects. Can anyone help me 
with information on how it's setup to handle interrupts and the rest?

DRH
