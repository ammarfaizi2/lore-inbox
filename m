Return-Path: <linux-kernel-owner+w=401wt.eu-S1762716AbWLKKOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762716AbWLKKOI (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 05:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762719AbWLKKOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 05:14:08 -0500
Received: from il.qumranet.com ([62.219.232.206]:34881 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762716AbWLKKOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 05:14:05 -0500
Message-ID: <457D2F6B.8070809@qumranet.com>
Date: Mon, 11 Dec 2006 12:14:03 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: kvm-devel@lists.sourceforge.net
CC: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: KVM: Miscellaneous updates
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In today's episode:
- two old patches that were accidentally dropped (by me)
- a fix for CONFIG_PREEMPT
- an mmu fix to ignore the cache control bits provided by the guest
- a MAINTAINERS entry to point the finger at the perpetrators

-- 
error compiling committee.c: too many arguments to function

