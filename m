Return-Path: <linux-kernel-owner+w=401wt.eu-S1161091AbWLPPwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161091AbWLPPwc (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 10:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161094AbWLPPwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 10:52:32 -0500
Received: from queue03-winn.ispmail.ntl.com ([81.103.221.57]:38072 "EHLO
	queue03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161091AbWLPPwb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 10:52:31 -0500
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.20-rc1 00/10] Kernel memory leak detector 0.13
To: linux-kernel@vger.kernel.org
Date: Sat, 16 Dec 2006 15:34:12 +0000
Message-ID: <20061216153346.18200.51408.stgit@localhost.localdomain>
User-Agent: StGIT/0.11
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches represent version 0.13 of the kernel memory
leak detector. See the Documentation/kmemleak.txt file for a more
detailed description. The patches are downloadable from (the whole
patch or the broken-out series) http://www.procode.org/kmemleak/

What's new in this version:

- updated to Linux 2.6.20-rc1
- fixed a bug noticeable with a big number of reported memory leaks

-- 
Catalin
