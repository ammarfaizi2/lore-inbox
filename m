Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbTD3Lzo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 07:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbTD3Lzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 07:55:44 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:17319 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP id S262101AbTD3Lzn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 07:55:43 -0400
Date: Wed, 30 Apr 2003 14:07:17 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Marc Zyngier <mzyngier@freesurf.fr>, rth@twiddle.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] DMA mapping API for Alpha
In-Reply-To: <20030429150532.A3984@jurassic.park.msu.ru>
Message-ID: <Pine.GSO.3.96.1030430140450.1016E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Apr 2003, Ivan Kokshaysky wrote:

> Since the Jensen is the only non-PCI alpha, I'd really prefer to
> keep existing pci_* functions as is and make dma_* ones just
> wrappers.

 Note that's the only non-PCI Alpha we support right now -- there may be
more such ones in the future. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

