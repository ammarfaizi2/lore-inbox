Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbUFTT1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbUFTT1Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 15:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263085AbUFTT1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 15:27:16 -0400
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224]:40934 "EHLO
	honk1.physik.uni-konstanz.de") by vger.kernel.org with ESMTP
	id S261880AbUFTT1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 15:27:15 -0400
Date: Sun, 20 Jun 2004 21:25:49 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Patch]: Fix rivafb's NV_ARCH_
Message-ID: <20040620192549.GA4307@bogon.ms20.nix>
References: <20040601041604.GA2344@bogon.ms20.nix> <1086064086.1978.0.camel@gaston> <20040601135335.GA5406@bogon.ms20.nix> <20040616070326.GE28487@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040616070326.GE28487@bogon.ms20.nix>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Wed, Jun 16, 2004 at 09:03:27AM +0200, Guido Guenther wrote:
> here's another piece of rivafb fixing that helps the driver on ppc
> pbooks again a bit further. It corrects several wrong NV_ARCH_20
> settings which are actually NV_ARCH_10 as determined by the PCIId.
Any comments on this patch?
 -- Guido
