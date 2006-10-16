Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbWJPN1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWJPN1T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 09:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbWJPN1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 09:27:18 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:7134 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750847AbWJPN1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 09:27:18 -0400
Subject: Re: Would SSI clustering extensions be of interest to kernel
	community?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Constantine Gavrilov <constg@qlusters.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <45337FE3.8020201@qlusters.com>
References: <45337FE3.8020201@qlusters.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Oct 2006 14:54:01 +0100
Message-Id: <1161006841.24237.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-10-16 am 14:49 +0200, ysgrifennodd Constantine Gavrilov:
> 2) Are kernel maintainers interested in clustering extensions to Linux 
> kernel? Do they see any value in them? (Our code does not require kernel 
> changes, but we are willing to submit it for inclusion if there is 
> interest.)

If they are doing SSI well and do not need core kernel changes then yes
they sound very interesting to me. Historically the big concern has
always been that things like this muck up the kernel core which affects
the other 99.99999% of users who don't want SSI clustering.

Alan

