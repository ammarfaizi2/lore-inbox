Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262016AbUL1CC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbUL1CC4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 21:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262017AbUL1CC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 21:02:56 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:64668 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262016AbUL1CCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 21:02:54 -0500
Subject: Re: [PATCH] i810 more AC97 tunings
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200412270726.iBR7QWxX032550@hera.kernel.org>
References: <200412270726.iBR7QWxX032550@hera.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104195539.22366.65.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 28 Dec 2004 00:59:00 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-12-27 at 06:20, Linux Kernel Mailing List wrote:
> ChangeSet 1.2189, 2004/12/26 22:20:06-08:00, alan@lxorguk.ukuu.org.uk
> 
> 	[PATCH] i810 more AC97 tunings
> 	
> 	Add some more funky AC97 knowledge to the intel8x0 driver. These come
> 	from Red Hat and its partners and are included in our shipping code.
> 	
> 	Signed-off-by: Alan Cox <alan@redhat.com>
> 	Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 

the ALSA guys confirmed this is not needed (they merged the changes
during the 2.6.9 changes but in a different sorted location).

Sorry
Alan

