Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbWIIOzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWIIOzS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 10:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbWIIOzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 10:55:18 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60385 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932240AbWIIOzQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 10:55:16 -0400
Subject: Re: [PATCH] optical /proc/ide/*/media
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
In-Reply-To: <20060907110846.GB5470@martell.zuzino.mipt.ru>
References: <20060907110846.GB5470@martell.zuzino.mipt.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 09 Sep 2006 16:18:18 +0100
Message-Id: <1157815098.6877.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-09-07 am 15:08 +0400, ysgrifennodd Alexey Dobriyan:
> Sergey Vlasov reported that his "FUJITSU MCC3064AP, ATAPI OPTICAL drive"
> pops up as UNKNOWN in /proc/ide/*/media .
> 
> Closes #4145.

Harmless but yes this seems sensible

Acked-by: Alan Cox <alan@redhat.com>

