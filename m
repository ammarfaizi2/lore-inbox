Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262653AbVCCWTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262653AbVCCWTy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 17:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbVCCWQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 17:16:55 -0500
Received: from fmr16.intel.com ([192.55.52.70]:4049 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S262677AbVCCWOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 17:14:34 -0500
Subject: Re: [thomas_cj_chang@wistron.com.tw: Kernel 2.4.28 can't boot into
	OS without noapic]
From: Len Brown <len.brown@intel.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       thomas_cj_chang@wistron.com.tw
Cc: mikpe@csd.uu.se, linux-kernel@vger.kernel.org
In-Reply-To: <20050303162736.GC7935@logos.cnet>
References: <20050303162736.GC7935@logos.cnet>
Content-Type: text/plain
Organization: 
Message-Id: <1109888058.2101.817.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 03 Mar 2005 17:14:18 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-03 at 11:27, Marcelo Tosatti wrote:
> Hi Thomas,
> 
> I'm forwarding your message to Mikael and Len, who have knowledge
> on the IOAPIC infrastructure.
> 
> ----- Forwarded message from thomas_cj_chang@wistron.com.tw -----
> 
> From: thomas_cj_chang@wistron.com.tw
> Date: Wed, 2 Mar 2005 13:37:03 +0800
> To: marcelo.tosatti@cyclades.com
> Subject: Kernel 2.4.28 can't boot into OS without noapic
> 
> Hi,
> 
> Sorry to interrupt you. I'm BIOS engineer from Taiwan. I found an
> kernel IO-APIC bug in my current project...

Thomas,
Is this specific to 2.4, or does 2.6 fail also?
Is this specific to MPS mode, or does ACPI mode fail also?

If this is a publically available platform, can you identify it so maybe
we can corrolate this with other reports?

thanks,
-Len


