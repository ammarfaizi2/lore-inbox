Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265207AbUGDQwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265207AbUGDQwY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 12:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265206AbUGDQwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 12:52:24 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:44473 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S265205AbUGDQwW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 12:52:22 -0400
Date: Sun, 4 Jul 2004 18:52:21 +0200
From: bert hubert <ahu@ds9a.nl>
To: Lasse Bang Mikkelsen <lbm-list@fatalerror.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange DMA timeouts
Message-ID: <20040704165221.GC18688@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Lasse Bang Mikkelsen <lbm-list@fatalerror.dk>,
	linux-kernel@vger.kernel.org
References: <1088958931.3205.8.camel@slaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1088958931.3205.8.camel@slaptop>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 04, 2004 at 06:35:31PM +0200, Lasse Bang Mikkelsen wrote:

> I keep getting these DMA timeouts under heavy harddrive load, ex. when
> unpacking big tarballs, transfering from USB harddrive etc.
> 
> hda: dma_timer_expiry: dma status == 0x21
> hda: DMA timeout error
> hda: dma timeout error: status=0xd0 { Busy }
> 
> hda: DMA disabled
> ide0: reset: success
> 
> Is this a sign of harddisk failure or could this be a kernel problem?

If you send your complete dmesg, perhaps people will be able to tell.
Include the boot messages. 


-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
