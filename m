Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbTI3WAc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 18:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbTI3WAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 18:00:32 -0400
Received: from mail.kroah.org ([65.200.24.183]:1233 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261786AbTI3WA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 18:00:28 -0400
Date: Tue, 30 Sep 2003 14:58:04 -0700
From: Greg KH <greg@kroah.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: tom@qwws.net, Brandon Low <lostlogic@gentoo.org>, jbinpg@shaw.ca,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: USB-problem with uhci-hcd in versions 2.6.0-test5 and 2.6.0-test6
Message-ID: <20030930215804.GB20864@kroah.com>
References: <20030929191850.A21072@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030929191850.A21072@infomag.infomag.iguana.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 29, 2003 at 07:18:50PM +0200, Wim Van Sebroeck wrote:
> Hi All,
> 
> I saw that you also reported problems with USB/uhci-hcd on your systems. Can you test
> the following patch and see if it works now?

I've applied this to my tree and will send it to Linus in the next batch
of USB updates.

thanks,

greg k-h
