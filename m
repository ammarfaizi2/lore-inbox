Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbULUTD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbULUTD4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 14:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbULUTCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 14:02:31 -0500
Received: from mail.kroah.org ([69.55.234.183]:25540 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261301AbULUS6R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 13:58:17 -0500
Date: Tue, 21 Dec 2004 10:58:01 -0800
From: Greg KH <greg@kroah.com>
To: Arne Caspari <arne@datafloater.de>
Cc: Arne Caspari <arnem@informatik.uni-bremen.de>,
       linux1394-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] ieee1394_core.c: remove unneeded EXPORT_SYMBOL's
Message-ID: <20041221185801.GA8784@kroah.com>
References: <41C694E0.8010609@informatik.uni-bremen.de> <20041220143901.GD457@phunnypharm.org> <1103555716.29968.27.camel@localhost.localdomain> <20041220154638.GE457@phunnypharm.org> <1103573716.31512.10.camel@localhost.localdomain> <41C7DFE9.5070604@informatik.uni-bremen.de> <20041221120012.GC5217@stusta.de> <41C81BF4.9070602@datafloater.de> <20041221171547.GD1459@kroah.com> <41C87099.9040108@datafloater.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C87099.9040108@datafloater.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2004 at 07:51:05PM +0100, Arne Caspari wrote:
> Greg KH schrieb:
> >On Tue, Dec 21, 2004 at 01:49:56PM +0100, Arne Caspari wrote:
> >>To make a long decision short:
> >>
> >>There is no stable kernel API that an external developer can rely on?
> >
> >That is correct.  Please see Documentation/stable_api_nonsense.txt for
> >details as to why this is so.
> 
> There is no such file in the 2.6.9 release :-(

It's in 2.6.10-rc3, and available online at:
	http://www.kroah.com/log/linux/stable_api_nonsense.html

thanks,

greg k-h
