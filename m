Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbWIYUEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbWIYUEz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 16:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWIYUEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 16:04:55 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:14751 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750837AbWIYUEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 16:04:54 -0400
Subject: Re: New section mismatch warning on latest linux-2.6 git tree
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Dave Jones <davej@redhat.com>, Ismail Donmez <ismail@pardus.org.tr>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060925112332.A30077@unix-os.sc.intel.com>
References: <EB12A50964762B4D8111D55B764A8454A41360@scsmsx413.amr.corp.intel.com>
	 <20060925182347.GB9683@redhat.com>
	 <20060925112332.A30077@unix-os.sc.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 25 Sep 2006 21:29:21 +0100
Message-Id: <1159216161.11049.135.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-09-25 am 11:23 -0700, ysgrifennodd Venkatesh Pallipadi:
> Patch below resolves this section mismatch issue.
> 
> Please apply.
> 
> Thanks,
> Venki

I was about to send the same

> Make the sections proper and get rid of section mismatch warnings.
> 
> Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Acked-by: Alan Cox <alan@redhat.com>


