Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964917AbVHIVsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917AbVHIVsh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 17:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbVHIVsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 17:48:37 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:21963 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S964914AbVHIVsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 17:48:36 -0400
Subject: Re: irqpoll causing some breakage?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Drake <dsd@gentoo.org>
Cc: linux-kernel@vger.kernel.org, mog.johnny@gmx.net
In-Reply-To: <42F8E3E3.1010201@gentoo.org>
References: <42F7FD5E.6000107@gentoo.org>
	 <1123605419.15600.35.camel@localhost.localdomain>
	 <42F8E3E3.1010201@gentoo.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 09 Aug 2005 23:14:57 +0100
Message-Id: <1123625697.19543.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-08-09 at 18:12 +0100, Daniel Drake wrote:
> Alan Cox wrote:
> > Without the parameters it has exactly zero effect on the operation of
> > the kernel, the algorithms and the behaviour. So something odd is afoot
> > if its causing gentoo breakages.
> 
> Thats what I thought, yet it seems to be the difference between mouse and no 
> mouse in this case.
> 
> Strange. We'll try a different compiler.

What do the other reports look like ?

