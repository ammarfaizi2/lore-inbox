Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131693AbRCTB3s>; Mon, 19 Mar 2001 20:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131692AbRCTB3i>; Mon, 19 Mar 2001 20:29:38 -0500
Received: from aic.ee.ndhu.edu.tw ([203.64.105.113]:28047 "EHLO
	aic.ee.ndhu.edu.tw") by vger.kernel.org with ESMTP
	id <S131611AbRCTB3Y>; Mon, 19 Mar 2001 20:29:24 -0500
Date: Tue, 20 Mar 2001 09:28:45 +0800
From: ³¯¤ý®i <cwz@aic.ee.ndhu.edu.tw>
To: Pierre Etchemaite <petchema@concept-micro.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About DC-315U scsi driver
Message-Id: <20010320092845.1953d505.cwz@aic.ee.ndhu.edu.tw>
In-Reply-To: <XFMail.20010319193049.petchema@concept-micro.com>
In-Reply-To: <20010313190304.62fbf6c7.cwz@aic.ee.ndhu.edu.tw>
	<XFMail.20010319193049.petchema@concept-micro.com>
X-Mailer: Sylpheed version 0.4.9 (GTK+ 1.2.8; Linux 2.4.2-ac20; i686)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Mar 2001 19:30:49 +0100 (CET)
Pierre Etchemaite <petchema@concept-micro.com> wrote:


> FYI, burning CDRs with this adapter seldom work under Windows too, Tekram
> adapters are usually fine, but those DC-315* & DC-395* really look like chip
> stuff...
> 
> BR,
> Pierre.
> 
> 

  I never have errors under MS-windows with VIA bridge chip. It's a problem
for me,when I start to use kernel 2.4.x. The timing between the new SCSI
layer and the Hardware of DC-315 has some mismatch.(I guess it)

  Maybe at sometimes,I would not like waiting a specific driver for it.
What's the best choice of SCSI card which support won't have errors and
the linux kernel won't give up supporting it???



Best Regards,cwz

