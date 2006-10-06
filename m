Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbWJFKxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWJFKxk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 06:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWJFKxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 06:53:40 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:14505 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751457AbWJFKxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 06:53:39 -0400
Subject: Re: [PATCH 3/5] ioremap balanced with iounmap for
	drivers/char/moxa.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Amol Lad <amol@verismonetworks.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1160110629.19143.90.camel@amol.verismonetworks.com>
References: <1160110629.19143.90.camel@amol.verismonetworks.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 06 Oct 2006 12:19:14 +0100
Message-Id: <1160133554.1607.62.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-10-06 am 10:27 +0530, ysgrifennodd Amol Lad:
> Signed-off-by: Amol Lad <amol@verismonetworks.com>
> ---
>  moxa.c |    6 ++++++
>  1 files changed, 6 insertions(+)
> ---


Looks ok to me

Signed-off-by: Alan Cox <alan@redhat.com>
