Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262014AbUL1B4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbUL1B4R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 20:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262017AbUL1B4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 20:56:16 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:63644 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262016AbUL1B4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 20:56:10 -0500
Subject: Re: PATCH: kmalloc packet slab
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@davemloft.net>
Cc: Patrick McHardy <kaber@trash.net>, torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
In-Reply-To: <20041227142350.1cf444fe.davem@davemloft.net>
References: <1104156983.20944.25.camel@localhost.localdomain>
	 <41D043AC.2070203@trash.net>  <20041227142350.1cf444fe.davem@davemloft.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104195085.20898.62.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 28 Dec 2004 00:51:28 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-12-27 at 22:23, David S. Miller wrote:
> If we are really going to do something like this, it should
> be calculated properly and be determined per-interface
> type as netdevs are registered.

Fine by me, I'm just going through plausible looking changes in the Red
Hat tree. You might want to slightly injure someone internally until
they drop that too 8)

Alan

