Return-Path: <linux-kernel-owner+w=401wt.eu-S932865AbWL1KHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932865AbWL1KHV (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 05:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932893AbWL1KHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 05:07:21 -0500
Received: from il.qumranet.com ([62.219.232.206]:39503 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932865AbWL1KHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 05:07:20 -0500
Message-ID: <45939755.7010603@qumranet.com>
Date: Thu, 28 Dec 2006 12:07:17 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: kvm-devel <kvm-devel@lists.sourceforge.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: [PATCH 0/8] KVM updates for 2.6.20-rc2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compatibility and stabilization fixes, many centered around msrs, but a 
few other corner cases as well.

-- 
error compiling committee.c: too many arguments to function

