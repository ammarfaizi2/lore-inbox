Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265418AbUFTWFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265418AbUFTWFw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 18:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265957AbUFTWFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 18:05:52 -0400
Received: from main.gmane.org ([80.91.224.249]:45713 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265418AbUFTWFv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 18:05:51 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: [Patch]: Fix rivafb's NV_ARCH_
Date: Mon, 21 Jun 2004 00:05:08 +0200
Message-ID: <MPG.1b40287d99901a459896cf@news.gmane.org>
References: <20040601041604.GA2344@bogon.ms20.nix> <1086064086.1978.0.camel@gaston> <20040601135335.GA5406@bogon.ms20.nix> <20040616070326.GE28487@bogon.ms20.nix> <20040620192549.GA4307@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-20-141.29-151.libero.it
X-Newsreader: MicroPlanet Gravity v2.60
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guido Guenther wrote:
> Hi,
> On Wed, Jun 16, 2004 at 09:03:27AM +0200, Guido Guenther wrote:
> > here's another piece of rivafb fixing that helps the driver on ppc
> > pbooks again a bit further. It corrects several wrong NV_ARCH_20
> > settings which are actually NV_ARCH_10 as determined by the PCIId.
> Any comments on this patch?

I applied it to 2.6.7; rivafb didn't work before, didn't work 
after :) (details are/were in the "Framebuffer with nVidia 
etc" thread)

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

