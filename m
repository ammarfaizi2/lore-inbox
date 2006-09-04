Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751349AbWIDNcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbWIDNcQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 09:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWIDNcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 09:32:16 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:22199 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751378AbWIDNcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 09:32:15 -0400
Subject: Re: [PATCH] [MM] 7/10 pci_module_init() conversion
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Henne <henne@nachtwindheim.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <44FC268D.2020506@nachtwindheim.de>
References: <44FC268D.2020506@nachtwindheim.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 04 Sep 2006 14:54:48 +0100
Message-Id: <1157378088.30801.79.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-09-04 am 15:13 +0200, ysgrifennodd Henne:
> From: Henrik Kretzschmar <henne@nachtwindheim.de>
> 
> pci_module_init() conversion for pata_pdc2027x
> For use in mm-tree only, since the new location of the ata drivers.
> In that case I don't know exactly how to change the version number.

Nor me or if it matters.

> Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

Acked-by: Alan Cox <alan@redhat.com>


