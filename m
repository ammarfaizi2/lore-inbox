Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965042AbWIJAMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965042AbWIJAMM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 20:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965041AbWIJAMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 20:12:12 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55175 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965043AbWIJAMK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 20:12:10 -0400
Subject: Re: [PATCH] alim15x3.c: M5229 (rev c8) support for DMA cd-writer
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Michael De Backer <micdb@skynet.be>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1157829145.6648.11.camel@mws.local.net>
References: <1157816221.5998.51.camel@mws.local.net>
	 <1157818525.6877.57.camel@localhost.localdomain>
	 <1157829145.6648.11.camel@mws.local.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 10 Sep 2006 01:35:22 +0100
Message-Id: <1157848522.6877.110.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-09-09 am 21:12 +0200, ysgrifennodd Michael De Backer:
> > I don't think that is what you mean..
> > 
> > NAK
> Indeed, let's try again (please forgive my dumbness). 

I've just put at least a dumb a mistake in 2.6.18 final so I wouldnt
worry - we all do it.

> Configuration bits are not set properly for DMA on some chipset
> revisions. It has already been corrected for M5229 (rev c7) but not for
> M5229 (rev c8). This leads to the bug described at
> http://bugzilla.kernel.org/show_bug.cgi?id=5786 (lost interrupt + ide
> bus hangs).
> 
> Signed-off-by: Michael De Backer <micdb@skynet.be>

Acked-by: Alan Cox <alan@redhat.com>


