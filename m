Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964884AbWJDOJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbWJDOJo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 10:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1160999AbWJDOJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 10:09:43 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:2736 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964888AbWJDOJm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 10:09:42 -0400
Subject: Re: [git patches] libata updates
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1159962434.25772.19.camel@localhost.localdomain>
References: <20061004060212.GA4653@havoc.gtf.org>
	 <1159962434.25772.19.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 04 Oct 2006 15:34:40 +0100
Message-Id: <1159972481.25772.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-10-04 am 12:47 +0100, ysgrifennodd Alan Cox:
> Ar Mer, 2006-10-04 am 02:02 -0400, ysgrifennodd Jeff Garzik:
> > Final libata batch for 2.6.19.  Meant to send this a couple days ago.
> > 
> > Nothing interesting:  minor bugfix, some cleanups, improved diagnostics.
> 
> Please also include the following. The first fixes support for rev c8 of
> the ALi/ULi PATA. The second keeps pcmcia in sync so ide_cs and
> pata_pcmcia are interchangable, both are only changes to constants.
> 
> Right now rev 0xC8 and higher don't work with libata but 0xc8 is in the
> field now.

Forgot

Signed-off-by: Alan Cox <alan@redhat.com>


