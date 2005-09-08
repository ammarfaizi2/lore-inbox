Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964890AbVIHQOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbVIHQOc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 12:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbVIHQOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 12:14:32 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:63658 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964892AbVIHQOb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 12:14:31 -0400
Subject: Re: Serial maintainership
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Dave Miller <davem@redhat.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050908165256.D5661@flint.arm.linux.org.uk>
References: <20050908165256.D5661@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 08 Sep 2005 17:38:43 +0100
Message-Id: <1126197523.19834.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-09-08 at 16:52 +0100, Russell King wrote:
> I notice DaveM's taken over serial maintainership.  Please arrange for
> serial patches to be sent to davem in future, thanks.  (All ARM serial
> drivers are broken as of Tuesday.)
> 
> I might take a different view if I at least had a curtious CC: of the
> patch, which I had already asked akpm to reject.
> 
> Thanks.  That's another subsystem I don't have to care about anymore.

Please remember to send Linus a patch updating MAINTAINERS if so.

