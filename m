Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbVHKSEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbVHKSEV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 14:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbVHKSEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 14:04:20 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:60864 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S932338AbVHKSEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 14:04:20 -0400
Date: Thu, 11 Aug 2005 14:04:18 -0400
To: Michael Thonke <iogl64nx@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Lee Revell <rlrevell@joe-job.com>,
       lgb@lgb.hu, Allen Martin <AMartin@nvidia.com>,
       linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: NCQ support NVidia NForce4 (CK804) SATAII
Message-ID: <20050811180418.GK31019@csclub.uwaterloo.ca>
References: <DBFABB80F7FD3143A911F9E6CFD477B004FAE3E7@hqemmail02.nvidia.com> <20050811070943.GB8025@vega.lgb.hu> <1123765523.32375.10.camel@mindpipe> <42FB6C27.1010408@gmail.com> <42FB88F8.7040807@pobox.com> <42FB8D04.8050006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42FB8D04.8050006@gmail.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2005 at 07:38:12PM +0200, Michael Thonke wrote:
> I have a ASUS A8V Deluxe too, and can't use the AMD X2 processor on 
> it...this is a feature..right?
> Supposed to run with DualCore but don't post..hm.

Well according to Asus you can if you run BIOS 1013 or 1014 on the
board.  Any less and it won't boot.

Now I certainly can't try it given I don't have such a CPU.

> My SATA II devices. Get not regonized from the VIA SATA 
> controller...this bug is known.
> So I want to use my HDD's I bought ...why should I set my SATA II device 
> to be SATA I.

So a SATA II drive doesn't work at all?

> Is also a feature of VIA Chipsets, right?
> 
> "It's not a bug, hey let's say is a feature."

Common practice it seems.

Len Sorensen
