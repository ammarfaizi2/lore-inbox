Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbWI3LmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWI3LmA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 07:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbWI3LmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 07:42:00 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:48594 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750857AbWI3Ll7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 07:41:59 -0400
Message-ID: <451E57FE.5000600@garzik.org>
Date: Sat, 30 Sep 2006 07:41:50 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Muli Ben-Yehuda <muli@il.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Jim Paradis <jparadis@redhat.com>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>, jdmason@kudzu.us
Subject: Re: [PATCH] x86[-64] PCI domain support
References: <20060926191508.GA6350@havoc.gtf.org> <20060928093332.GG22787@rhun.haifa.ibm.com> <451B99C5.7080809@garzik.org> <20060928224550.GJ22787@rhun.haifa.ibm.com> <451C54C0.6080402@garzik.org> <20060928233116.GK22787@rhun.haifa.ibm.com> <20060930093421.GP22787@rhun.haifa.ibm.com> <451E40DF.30406@garzik.org> <20060930104248.GR22787@rhun.haifa.ibm.com>
In-Reply-To: <20060930104248.GR22787@rhun.haifa.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Muli Ben-Yehuda wrote:
> The patch I posted earlier is all that's needed, if you could merge it
> into #pciseg that would be fine. I'm pondering making one small
> change though: in your pci domains patch, you have this snippet:

Would you be kind enough to resend the patch with a proper Signed-off-by 
line?  (and subject/description, etc. while you're at it)

Thanks,

	Jeff


