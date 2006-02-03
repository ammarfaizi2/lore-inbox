Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945904AbWBCTPG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945904AbWBCTPG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 14:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945903AbWBCTPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 14:15:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42112 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1945900AbWBCTPB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 14:15:01 -0500
Date: Fri, 3 Feb 2006 11:14:23 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: <takis.issaris@uhasselt.be>, linux-kernel@vger.kernel.org
Subject: Re: WLAN drivers
Message-Id: <20060203111423.17275a33.zaitcev@redhat.com>
In-Reply-To: <mailman.1138977902.23981.linux-kernel2news@redhat.com>
References: <1138969138.8434.26.camel@localhost.localdomain>
	<mailman.1138977902.23981.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Feb 2006 12:35:30 +0000, Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:

> > And now the reason I'm sending this to this mailing list: Which wireless
> > network cards are you all using and which ones would you recommend? Is
> > anyone using USB wireless network cards (without using ndiswrapper)?
> 
> In my experience, you're simply best going to either http://prism54.org/ (if 
> you can find one still)

You can't get a fullmac card anymore, but softmac is still available
 http://www.cdw.com/shop/products/default.aspx?EDC=543916
It's a gen1, too.

> Keywords for _modern_ Linux supported wireless chipsets are still (to my 
> knowledge) atheros, atmel, prism54, and most recently broadcom, though that 
> support is currently immature.

Intel is the king, dude. Get a 2200. Uses in-tree drivers, too.

-- Pete
