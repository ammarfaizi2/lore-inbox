Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266626AbUFWTgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266626AbUFWTgB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 15:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266628AbUFWTgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 15:36:01 -0400
Received: from [213.146.154.40] ([213.146.154.40]:30619 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266626AbUFWTf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 15:35:58 -0400
Date: Wed, 23 Jun 2004 20:35:56 +0100 (BST)
From: jsimmons@pentafluge.infradead.org
To: Guido Guenther <agx@sigxcpu.org>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Patch]: Fix rivafb's NV_ARCH_
In-Reply-To: <20040620192549.GA4307@bogon.ms20.nix>
Message-ID: <Pine.LNX.4.56.0406232035340.27210@pentafluge.infradead.org>
References: <20040601041604.GA2344@bogon.ms20.nix> <1086064086.1978.0.camel@gaston>
 <20040601135335.GA5406@bogon.ms20.nix> <20040616070326.GE28487@bogon.ms20.nix>
 <20040620192549.GA4307@bogon.ms20.nix>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: 0.3 (/)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (0.3 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 NO_REAL_NAME           From: does not include a real name
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Could you compare it to my latest Nvidia driver? 



On Sun, 20 Jun 2004, Guido Guenther wrote:

> Hi,
> On Wed, Jun 16, 2004 at 09:03:27AM +0200, Guido Guenther wrote:
> > here's another piece of rivafb fixing that helps the driver on ppc
> > pbooks again a bit further. It corrects several wrong NV_ARCH_20
> > settings which are actually NV_ARCH_10 as determined by the PCIId.
> Any comments on this patch?
>  -- Guido
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
