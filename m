Return-Path: <linux-kernel-owner+w=401wt.eu-S965333AbXAKKC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965333AbXAKKC1 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 05:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965341AbXAKKC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 05:02:27 -0500
Received: from il.qumranet.com ([62.219.232.206]:41446 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965333AbXAKKC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 05:02:27 -0500
Message-ID: <45A60B2F.6090901@qumranet.com>
Date: Thu, 11 Jan 2007 12:02:23 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: kvm-devel <kvm-devel@lists.sourceforge.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: [PATCH 0/5] KVM updates for 2.6.20
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patchset contains important kvm stability fixes for Linux 
2.6.20.  Most of the patches fix regressions introduced (or exposed) by 
the mmu optimization work; there's also a fix for an ancient (but 
serious) bug from the early days of kvm.

-- 
error compiling committee.c: too many arguments to function

