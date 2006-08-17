Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbWHQLEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWHQLEv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 07:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbWHQLEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 07:04:51 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:23271 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964802AbWHQLEu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 07:04:50 -0400
Subject: Re: GPL Violation?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Patrick McFarland <diablod3@gmail.com>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Anonymous User <anonymouslinuxuser@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200608170536.44733.diablod3@gmail.com>
References: <40d80630608162248y498cb970r97a14c582fd663e1@mail.gmail.com>
	 <200608170242.40969.diablod3@gmail.com>
	 <44E429B3.7030607@s5r6.in-berlin.de>
	 <200608170536.44733.diablod3@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 17 Aug 2006 12:25:36 +0100
Message-Id: <1155813936.15195.57.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-17 am 05:36 -0400, ysgrifennodd Patrick McFarland:
> > If a driver author doesn't want 
> > to publish under the terms of GPL, an implementation in userspace may
> > make it possible to avoid linking with GPL code.
> 
> But doesn't that force the GPL code to rely on closed source code, and not 
> function properly without it? I remember a part in the GPL about not allowing 
> that, but I can't seem to find it atm.

It shouldn't generally be a grey area but that is why the Linux kernel
has always had this clarification in COPYING about the interpretation

  NOTE! This copyright does *not* cover user programs that use kernel
 services by normal system calls - this is merely considered normal use
 of the kernel, and does *not* fall under the heading of "derived work".
 Also note that the GPL below is copyrighted by the Free Software
 Foundation, but the instance of code that it refers to (the Linux
 kernel) is copyrighted by me and others who actually wrote it.

