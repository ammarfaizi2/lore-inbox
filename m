Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754757AbWKII0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754757AbWKII0c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 03:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbWKII0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 03:26:31 -0500
Received: from mx.go2.pl ([193.17.41.41]:11439 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S932430AbWKII0M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 03:26:12 -0500
Date: Thu, 9 Nov 2006 09:32:05 +0100
From: Jarek Poplawski <jarkao2@o2.pl>
To: Stephen.Clark@seclark.us
Cc: linux-kernel@vger.kernel.org
Subject: Re: New laptop - problems with linux
Message-ID: <20061109083205.GA976@ff.dom.local>
Mail-Followup-To: Jarek Poplawski <jarkao2@o2.pl>, Stephen.Clark@seclark.us,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4551EC86.5010600@seclark.us>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-11-2006 15:41, Stephen Clark wrote:
> Hi list,
> 
> I just purchased a VBI-Asus S96F laptop Intel 945GM &  ICH7, with a Core 
> 2 Duo T560,0 2gb pc5400 memory.
>  From checking around it appeared all the
> hardware was well supported by linux - but I am having major problems.
> 
> 
> 1. neither the wireless lan Intel pro 3945ABG or built in ethernet 
> RTL-8169C are detected and configured
> 2. the disk which is a 7200rpm Hitachi travelmate transfers data at 1.xx 
> mb/sec
>    according to hdparm. This same drive in my old laptop an HP n5430 with a
>    850 duron the rate was 12-14 mb/sec.
... 
> Kernel command line: ro root=/dev/VolGroup00/LogVol00 ide1=dma ide1=ata66
> ide_setup: ide1=dma -- OBSOLETE OPTION, WILL BE REMOVED SOON!
> ide_setup: ide1=ata66 -- OBSOLETE OPTION, WILL BE REMOVED SOON!

Could you repeat the reason for this ides in kernel parameters?
Did you try to boot some fresh live-cd distro?

Jarek P.
