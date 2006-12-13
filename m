Return-Path: <linux-kernel-owner+w=401wt.eu-S964965AbWLMNP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbWLMNP2 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 08:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbWLMNPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 08:15:16 -0500
Received: from il.qumranet.com ([62.219.232.206]:47438 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964965AbWLMNOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 08:14:17 -0500
Message-ID: <457FF542.6050602@qumranet.com>
Date: Wed, 13 Dec 2006 14:42:42 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: kvm-devel@lists.sourceforge.net
CC: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: [PATCH 0/3] KVM: Updates
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A cleanup and two AMD SVM fixes (the STAR MSR on 32-bit hosts, and the 
floating point unit state on all AMD hosts).

-- 
error compiling committee.c: too many arguments to function

