Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751580AbWHXOfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580AbWHXOfl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 10:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751586AbWHXOfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 10:35:41 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:13204 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751565AbWHXOfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 10:35:40 -0400
Subject: Re: [PATCH] libata : Add 40pin "short" cable support, honour drive
	side speed detection
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <44EDAEFC.6000609@pobox.com>
References: <1156188229.18887.56.camel@localhost.localdomain>
	 <44ED4DB5.10400@pobox.com> <1156417070.3007.64.camel@localhost.localdomain>
	 <44EDAEFC.6000609@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 24 Aug 2006 15:56:25 +0100
Message-Id: <1156431385.3007.153.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-24 am 09:51 -0400, ysgrifennodd Jeff Garzik:
> The standard policy, in place since you began, has been to push core 
> stuff into #upstream, and the driver side into #pata-drivers.

Jeff, I've no problem with putting it in upstream but all this talk of
"standard policy" is crap. Or at least "standard policy" is a concept
existing only in Jeff's brain and not documented clearly externally in
this case...


