Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265613AbTFWXLl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 19:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265592AbTFWXJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 19:09:28 -0400
Received: from cmsrelay01.mx.net ([165.212.11.110]:8187 "HELO
	cmsrelay01.mx.net") by vger.kernel.org with SMTP id S265573AbTFWXIN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 19:08:13 -0400
X-USANET-Auth: 165.212.8.8     AUTO bradtilley@usa.net uwdvg008.cms.usa.net
Date: Mon, 23 Jun 2003 19:22:16 -0400
From: Brad Tilley <bradtilley@usa.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: [OS Fails to Load]
X-Mailer: USANET web-mailer (CM.0402.5.6)
Mime-Version: 1.0
Message-ID: <868HFwXwq9072S08.1056410536@uwdvg008.cms.usa.net>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please disregard these messages. I think this is a RH specific startup script
issue and not a kernel issue. Sorry for the inconvenience.

Brad Tilley <bradtilley@usa.net> wrote:
> Hello,
> 
> 50% of the time when I boot RH Linux 9 (2.4.20-18.9) the OS fails to load.
The
> failure usually occurs during a period of intense disk activity such as
> 'finding module dependencies' or 'mounting local filesystems'. I can
reproduce
> this error with the most recent RH kernel and the kernel that the distro
> originally shipped with and 2.4.21 from Kernel.org built using RH's config
> files. Usually after 4-5 power cycles, the OS loads OK and the machine runs
> fine once it gets going.
> 
> It's a HP xw4100 with these specs:
> 
> P4 Processor 3.00GHz/800 FSB
> 1.5GB DDR/400 ECC (2x512, 2x256)
> NVIDIA Quadro4 200NVS 64MB AGP
> Ultra320 SCSI Controller
> 18GB Ultra 320 SCSI 15,000rpm Hard Drive (sda)
> 146GB Ultra 320 SCSI 10,000rpm Hard Drive (sdb)
> 48X DVD/CDRW Combo Drive
> 48X CD-RW Drive
> Broadcom Gbit 10/100/1000
> 
> Can someone help me troubleshoot this? I'm at the end of my rope. I have
the
> most recent BIOS from HP.
> 
> 
> Thanks,
> Brad
> 
> 
> 



