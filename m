Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbVHKR1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbVHKR1V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 13:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbVHKR1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 13:27:21 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:32957 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S932246AbVHKR1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 13:27:20 -0400
Date: Thu, 11 Aug 2005 13:27:18 -0400
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Michael Thonke <iogl64nx@gmail.com>, Lee Revell <rlrevell@joe-job.com>,
       lgb@lgb.hu, Allen Martin <AMartin@nvidia.com>,
       linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: NCQ support NVidia NForce4 (CK804) SATAII
Message-ID: <20050811172718.GJ31019@csclub.uwaterloo.ca>
References: <DBFABB80F7FD3143A911F9E6CFD477B004FAE3E7@hqemmail02.nvidia.com> <20050811070943.GB8025@vega.lgb.hu> <1123765523.32375.10.camel@mindpipe> <42FB6C27.1010408@gmail.com> <42FB88F8.7040807@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42FB88F8.7040807@pobox.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2005 at 01:20:56PM -0400, Jeff Garzik wrote:
> What specifically does not work, on VIA+AMD64 combination, under Linux?
> 
> My Athlon64 with VIA chipset works great.

Mine does too.  Asus A8V Deluxe.  No problems so far.  Everything on the
board I have tried just works.

Can't say my A7N8X-E Deluxe has any real issues either.  I may only get
ac97 audio level out of the nifty DSP, but I hardly use sound on the
system anyhow, so I don't mind.  forcedeth driver works for networking,
sil3112a sata works with WD drives no problem, nvidia ide controller
seems to work fine with dvd drives, firewire works, yukon sk98lin works
too, usb is fine.  No complaints from me.

Len Sorensen
