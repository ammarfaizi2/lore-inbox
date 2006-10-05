Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbWJEVh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWJEVh5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWJEVh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:37:57 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:32475 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932231AbWJEVh4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:37:56 -0400
Subject: Re: [PATCH] Consolidate check_signature
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Wilcox <matthew@wil.cx>
In-Reply-To: <11600679552794-git-send-email-matthew@wil.cx>
References: <11600679551209-git-send-email-matthew@wil.cx>
	 <11600679552794-git-send-email-matthew@wil.cx>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 05 Oct 2006 23:03:43 +0100
Message-Id: <1160085823.1607.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-10-05 am 11:05 -0600, ysgrifennodd Matthew Wilcox:
> There's nothing arch-specific about check_signature(), so move it to
> <linux/io.h>.  Use a cross between the Alpha and i386 implementations
> as the generic one.
> 
> Signed-off-by: Matthew Wilcox <willy@parisc-linux.org>

Acked-by: Alan Cox <alan@redhat.com>

