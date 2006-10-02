Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbWJBNyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbWJBNyH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 09:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWJBNyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 09:54:07 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:15319 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932331AbWJBNyG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 09:54:06 -0400
Subject: Re: [PATCH] schedule ftape removal
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jeff@garzik.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       linux-tape@vger.kernel.org
In-Reply-To: <20061002050528.GA10288@havoc.gtf.org>
References: <20061002050528.GA10288@havoc.gtf.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 02 Oct 2006 14:01:57 +0100
Message-Id: <1159794117.8907.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-10-02 am 01:05 -0400, ysgrifennodd Jeff Garzik:
> +What:	ftape
> +When:	2.6.20
> +Why:	Orphaned for ages.  SMP bugs long unfixed.  Few users left
> +	in the world.
> +Who:	Jeff Garzik <jeff@garzik.org>


Acked-by: Alan Cox <alan@redhat.com>

Everyone has used the out of tree one for a long time anyway if there is
even a user left. I guess the person who needs to rescue ancient tapes
will use an old kernel and PC anyway, or can rescue the driver
themselves.


