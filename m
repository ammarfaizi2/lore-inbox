Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422755AbWJFRHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422755AbWJFRHn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 13:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422756AbWJFRHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 13:07:42 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:40155 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1422755AbWJFRHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 13:07:42 -0400
Date: Fri, 6 Oct 2006 11:07:41 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PATCH] Rename pdc_init
Message-ID: <20061006170741.GK2563@parisc-linux.org>
References: <11601511393703-git-send-email-matthew@wil.cx> <4526876A.5090103@garzik.org> <1160155822.1607.110.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160155822.1607.110.camel@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2006 at 06:30:21PM +0100, Alan Cox wrote:
> Ar Gwe, 2006-10-06 am 12:42 -0400, ysgrifennodd Jeff Garzik:
> > Matthew Wilcox wrote:
> > > parisc uses pdc_init() for different purposes, so call it pdc202xx_init
> > > instead.
> > > 
> > > Signed-off-by: Matthew Wilcox <matthew@wil.cx>
> > 
> > I don't mind the patch (you should have CC'd me and linux-ide though), 
> > but where is parisc's pdc_init actually used, and why is it global?
> 
> Can you cc me the patch as well ?

Um, I did.  Did your spamfilter eat it?

From: Matthew Wilcox <matthew@wil.cx>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>

