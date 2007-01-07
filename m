Return-Path: <linux-kernel-owner+w=401wt.eu-S932534AbXAGNRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534AbXAGNRe (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 08:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbXAGNRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 08:17:34 -0500
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:14732 "EHLO
	mis011-1.exch011.intermedia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932534AbXAGNRd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 08:17:33 -0500
Message-ID: <45A0F2E7.4020102@qumranet.com>
Date: Sun, 07 Jan 2007 15:17:27 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: kvm-devel <kvm-devel@lists.sourceforge.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] kvm-10 release
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Jan 2007 13:17:32.0960 (UTC) FILETIME=[30C0BA00:01C7325E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from kvm-9:

- more hypercall work
- cleanup irq handling
- shadow page table caching
- migration fixes
- stabilization fixes

This release is significantly faster than previous releases; upgrading 
is recommended.

http://kvm.sourceforge.net

-- 
error compiling committee.c: too many arguments to function

