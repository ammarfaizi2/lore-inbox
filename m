Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbUEGAjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbUEGAjs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 20:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbUEGAjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 20:39:48 -0400
Received: from hera.kernel.org ([63.209.29.2]:44734 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261865AbUEGAjq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 20:39:46 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [PATCH 2.6.6-rc3] Lindent on arch/i386/kernel/msr.c
Date: Fri, 7 May 2004 00:39:08 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c7elrc$ddm$1@terminus.zytor.com>
References: <50390000.1083882659@dyn318071bld.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1083890348 13751 127.0.0.1 (7 May 2004 00:39:08 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 7 May 2004 00:39:08 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <50390000.1083882659@dyn318071bld.beaverton.ibm.com>
By author:    Hanna Linder <hannal@us.ibm.com>
In newsgroup: linux.dev.kernel
>
> 
> Per Greg's request this is a patch of having run Lindent on msr.c.
> The tabs were not the right number of spaces before. I also added a semicolon
> after the module_exit statement to make Lindent do the right thing wrt the
> spacing of the MODULE_AUTHOR. I have compiled and booted to verify this 
> change does not break anything.

Please don't apply this right now.  I'm in the middle of making a change to
the msr and cpuid modules.

(Also, please Cc: the author/maintainer, in this case myself, when
making these kinds of changes.)

Thanks,

	-hpa
