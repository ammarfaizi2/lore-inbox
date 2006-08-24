Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbWHXKiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbWHXKiF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 06:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbWHXKiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 06:38:04 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42180 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751066AbWHXKiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 06:38:01 -0400
Subject: Re: [PATCH] libata : Add 40pin "short" cable support, honour drive
	side speed detection
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <44ED4DB5.10400@pobox.com>
References: <1156188229.18887.56.camel@localhost.localdomain>
	 <44ED4DB5.10400@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 24 Aug 2006 11:57:49 +0100
Message-Id: <1156417070.3007.64.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-24 am 02:56 -0400, ysgrifennodd Jeff Garzik:
> ACK, but you need to split this up into core (#upstream) and PATA 
> (#pata-drivers) patches.

Its not really needed until you have pata drivers so I was planning to
submit it only for the pata-drivers side of things ?

Alan

