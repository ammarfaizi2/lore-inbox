Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422753AbWJFRFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422753AbWJFRFx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 13:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422754AbWJFRFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 13:05:53 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:31400 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422753AbWJFRFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 13:05:52 -0400
Subject: Re: [PATCH] [PATCH] Rename pdc_init
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jeff@garzik.org>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org
In-Reply-To: <4526876A.5090103@garzik.org>
References: <11601511393703-git-send-email-matthew@wil.cx>
	 <4526876A.5090103@garzik.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 06 Oct 2006 18:30:21 +0100
Message-Id: <1160155822.1607.110.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-10-06 am 12:42 -0400, ysgrifennodd Jeff Garzik:
> Matthew Wilcox wrote:
> > parisc uses pdc_init() for different purposes, so call it pdc202xx_init
> > instead.
> > 
> > Signed-off-by: Matthew Wilcox <matthew@wil.cx>
> 
> I don't mind the patch (you should have CC'd me and linux-ide though), 
> but where is parisc's pdc_init actually used, and why is it global?

Can you cc me the patch as well ?

