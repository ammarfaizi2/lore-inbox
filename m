Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269712AbUINTY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269712AbUINTY5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 15:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269711AbUINTXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 15:23:36 -0400
Received: from mail.kroah.org ([69.55.234.183]:32974 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269731AbUINTMl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 15:12:41 -0400
Date: Tue, 14 Sep 2004 11:55:06 -0700
From: Greg KH <greg@kroah.com>
To: Eric Valette <eric.valette@free.fr>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       petkan@nucleusys.com
Subject: Re: rtl8150.c ethernet driver : usb_unlink_urb ->usb_kill_urb
Message-ID: <20040914185506.GA20942@kroah.com>
References: <413DB68C.7030508@free.fr> <4140256C.5090803@free.fr> <20040909152454.14f7ebc9.akpm@osdl.org> <20040909223605.GA17655@kroah.com> <414335FB.8050203@free.fr> <414336DD.9030003@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414336DD.9030003@free.fr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2004 at 07:33:17PM +0200, Eric Valette wrote:
> Eric Valette wrote:
> >
> >>I'll defer to Petkan as to what to do about this, as he sent me that
> >>patch for a good reason I imagine :)
> >
> >
> >While we are looking at this driver, here is a way to avoid one full 
> >page of annoying messages at shutdown/module unload.
> >
> >Signed-off-by: Eric Valette <Eric.Valette@free.fr>
> 
> Wrong patch, sorry...

Applied, thanks.

greg k-h
