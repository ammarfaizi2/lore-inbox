Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751690AbWHSJ2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbWHSJ2K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 05:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751685AbWHSJ2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 05:28:09 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:19079 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751682AbWHSJ2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 05:28:05 -0400
Subject: Re: [PATCH 2.6.18-rc4] aoe [10/13]: module parameter for device
	timeout
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Ed L. Cashin" <ecashin@coraid.com>
Cc: linux-kernel@vger.kernel.org, Greg K-H <greg@kroah.com>
In-Reply-To: <20060818231037.GW29988@coraid.com>
References: <E1GE8K3-0008Jn-00@kokone.coraid.com>
	 <a47db3897e5de69fbe6bfaf1fea169a2@coraid.com>
	 <1155942187.31543.26.camel@localhost.localdomain>
	 <20060818231037.GW29988@coraid.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 19 Aug 2006 01:09:11 +0100
Message-Id: <1155946151.31543.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-08-18 am 19:10 -0400, ysgrifennodd Ed L. Cashin:
> No, this is just for users who need very fast failure.  The default
> three minutes is good for things like short network interruptions and
> even quick AoE device reboots, but users who aren't interested in that
> kind of flexibility and want a fast failure generally want it always
> and on every link.

Ok, but it should still be runtime settable.

