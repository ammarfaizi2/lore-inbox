Return-Path: <linux-kernel-owner+w=401wt.eu-S1161003AbXAEHtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161003AbXAEHtG (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 02:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161004AbXAEHtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 02:49:06 -0500
Received: from mis011.exch011.intermedia.net ([64.78.21.10]:22907 "EHLO
	mis011.exch011.intermedia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161003AbXAEHtF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 02:49:05 -0500
Message-ID: <459E02E7.5020407@qumranet.com>
Date: Fri, 05 Jan 2007 09:48:55 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: kvm-devel@lists.sourceforge.net
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: [PATCH 0/9] KVM: Flush out my patch queue
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Jan 2007 07:49:03.0291 (UTC) FILETIME=[F80C68B0:01C7309D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is mostly fallout from the mmu stuff that I've neglected 
to integrate with the main patchset sent yesterday.  It includes a 
fashionable missing dirty bit fix, and other fixes and cleanups.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

