Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbWJEVkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWJEVkX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWJEVkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:40:23 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34779 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932246AbWJEVkU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:40:20 -0400
Subject: Re: [PATCH] Use linux/io.h instead of asm/io.h
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org, Matthew Wilcox <willy@parisc-linux.org>
In-Reply-To: <11600679551209-git-send-email-matthew@wil.cx>
References: <11600679551209-git-send-email-matthew@wil.cx>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 05 Oct 2006 23:04:12 +0100
Message-Id: <1160085852.1607.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-10-05 am 11:05 -0600, ysgrifennodd Matthew Wilcox:
> In preparation for moving check_signature, change these users from
> asm/io.h to linux/io.h
> 
> Signed-off-by: Matthew Wilcox <willy@parisc-linux.org>

Acked-by: Alan Cox <alan@redhat.com>

