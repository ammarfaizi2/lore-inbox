Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262157AbVGFKJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbVGFKJx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 06:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbVGFKGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 06:06:43 -0400
Received: from fmr19.intel.com ([134.134.136.18]:29119 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S262116AbVGFIUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 04:20:05 -0400
Subject: Re: [PATCH] [16/48] Suspend2 2.1.9.8 for 2.6.12:
	406-dynamic-pageflags.patch
From: Shaohua Li <shaohua.li@intel.com>
To: ncunningham@cyclades.com
Cc: Nigel Cunningham <nigel@suspend2.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1120637607.4860.34.camel@localhost>
References: <11206164411593@foobar.com>
	 <1120635983.6970.4.camel@linux-hp.sh.intel.com>
	 <1120637607.4860.34.camel@localhost>
Content-Type: text/plain
Date: Wed, 06 Jul 2005 16:30:32 +0800
Message-Id: <1120638632.2908.0.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-06 at 18:13 +1000, Nigel Cunningham wrote:
> Hi.
> 
> On Wed, 2005-07-06 at 17:46, Shaohua Li wrote:
> > we are using cpu hotplug for S3 & S4 SMP to avoid nasty deadlocks. Could
> > this be avoided in suspend2 SMP?
> 
> I haven't had any problems with this code but yes, I do want to switch
> to using hotplug. It's only in -mm, not mainline?
It's in base kernel now.

Thanks,
Shaohua

