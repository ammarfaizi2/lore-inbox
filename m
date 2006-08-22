Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbWHVH2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWHVH2b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 03:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWHVH2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 03:28:31 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:46798
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751335AbWHVH2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 03:28:30 -0400
Date: Tue, 22 Aug 2006 00:28:45 -0700 (PDT)
Message-Id: <20060822.002845.08658116.davem@davemloft.net>
To: mchan@broadcom.com
Cc: henne@nachtwindheim.de, akpm@osdl.org, jgarzik@pobox.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [NET] [TG3] Convert the pci_device_it table to
 PCI_DEVICE()
From: David Miller <davem@davemloft.net>
In-Reply-To: <1155941321.4201.1.camel@rh4>
References: <44E195B2.3070406@nachtwindheim.de>
	<1155941321.4201.1.camel@rh4>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael Chan" <mchan@broadcom.com>
Date: Fri, 18 Aug 2006 15:48:41 -0700

> On Tue, 2006-08-15 at 11:36 +0200, Henne wrote:
> > From: Henrik Kretzschmar <henne@nachtwindheim.de>
> > 
> > Convert the pci_device_ids to PCI_DEVICE() macro.
> > Saves 1.5k in the sourcefile.
> > 
> > Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>
> > ---
> 
> Acked-by: Michael Chan <mchan@broadcom.com>

Applied, thanks everyone.
