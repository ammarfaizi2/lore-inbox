Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268941AbRHPWqH>; Thu, 16 Aug 2001 18:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268936AbRHPWp5>; Thu, 16 Aug 2001 18:45:57 -0400
Received: from [209.10.41.242] ([209.10.41.242]:8379 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S268941AbRHPWpq>;
	Thu, 16 Aug 2001 18:45:46 -0400
Subject: Re: 2.4.9 does not compile [PATCH]
To: davem@redhat.com (David S. Miller)
Date: Thu, 16 Aug 2001 23:41:07 +0100 (BST)
Cc: tpepper@vato.org, f5ibh@db0bm.ampr.org, linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "David S. Miller" at Aug 16, 2001 03:31:51 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15XVp6-0006EW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The args and semantics of min/max changed to take
> a type first argument, the problem with this ntfs file is that it
> fails to include linux/kernel.h

Thank you for your detailed discussion of this in advance on the kernel
list, your careful consideration of the 2.2 compatibility work horrors you
introduced and the thoughtful way you notified maintainers.

And all this from a man who gives me an earful if I merge third party
network patches without going through him.

Alan
