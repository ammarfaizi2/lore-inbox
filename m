Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162030AbWLAVuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162030AbWLAVuF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 16:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162038AbWLAVuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 16:50:04 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:16273 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1162030AbWLAVuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 16:50:03 -0500
Date: Fri, 1 Dec 2006 21:57:00 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19: ALi M5229 - CD-ROM not found with pata_ali
Message-ID: <20061201215700.34d1e1ff@localhost.localdomain>
In-Reply-To: <200612012335.29179.arvidjaar@mail.ru>
References: <200606220004.30863.arvidjaar@mail.ru>
	<200612012335.29179.arvidjaar@mail.ru>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Still the same in 2.6.19 + suspend pata_ali patch. The only way I can get 
> CD-ROM is with
> 
> options pata_ali atapi_max_xfer_mask=0x7f

And I've still got no idea why. Having studied the docs, the old and new
drivers and a lot more I see no difference to explain it. 

Alan
