Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268115AbUJOQBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268115AbUJOQBz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 12:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268097AbUJOQBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 12:01:54 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:50906 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S268115AbUJOQAi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 12:00:38 -0400
X-Envelope-From: kraxel@bytesex.org
To: Andi Kleen <ak@muc.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, KendallB@scitechsoft.com,
       linux-kernel@vger.kernel.org
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
References: <2Pkf0-42m-11@gated-at.bofh.it> <2PncW-6j9-19@gated-at.bofh.it>
	<2PncW-6j9-21@gated-at.bofh.it> <20030401205016$5cc4@gated-at.bofh.it>
	<20030401205016$63f7@gated-at.bofh.it>
	<20030424075011$4028@gated-at.bofh.it> <1ewKr-2Kh-41@gated-at.bofh.it>
	<CebL.O9.13@gated-at.bofh.it> <1bucs-57R-33@gated-at.bofh.it>
	<2PncW-6j9-23@gated-at.bofh.it> <20030423094012$4166@gated-at.bofh.it>
	<2PncW-6j9-17@gated-at.bofh.it> <2PAMY-7Ir-21@gated-at.bofh.it>
	<m3655cjc1r.fsf@averell.firstfloor.org>
From: Gerd Knorr <kraxel@bytesex.org>
Organization: SUSE Labs, Berlin
Date: 15 Oct 2004 17:37:09 +0200
In-Reply-To: <m3655cjc1r.fsf@averell.firstfloor.org>
Message-ID: <87u0swouvu.fsf@bytesex.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> writes:

> The problem is that this would imply that the console would only
> work after user space is running. Even with initrd that's quite late.

klibc + initramfs + early userspace?

  Gerd

-- 
return -ENOSIG;
