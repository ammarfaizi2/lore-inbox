Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261743AbUKPTnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbUKPTnR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 14:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261811AbUKPTlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 14:41:04 -0500
Received: from mail.kroah.org ([69.55.234.183]:226 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262126AbUKPTjL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 14:39:11 -0500
Date: Tue, 16 Nov 2004 11:38:36 -0800
From: Greg KH <greg@kroah.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: rcpt-linux-fsdevel.AT.vger.kernel.org@jankratochvil.net,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
Message-ID: <20041116193836.GB10327@kroah.com>
References: <20041116120226.A27354@pauline.vellum.cz> <E1CU3tO-0000rV-00@dorka.pomaz.szeredi.hu> <20041116163314.GA6264@kroah.com> <E1CU6SL-0007FP-00@dorka.pomaz.szeredi.hu> <20041116170339.GD6264@kroah.com> <E1CU7Tg-0007O8-00@dorka.pomaz.szeredi.hu> <20041116175857.GA9213@kroah.com> <E1CU8hS-0007U5-00@dorka.pomaz.szeredi.hu> <20041116191643.GA10021@kroah.com> <E1CU91x-0007Xw-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CU91x-0007Xw-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2004 at 08:30:21PM +0100, Miklos Szeredi wrote:
> > Any ioctls?  Any wierd, non-chardev like things?
> 
> Nothing extraordinary.  Messages are sent/received with plain read and
> write.

Ok, that sounds acceptable.

> > Again, inline code would have been nice to see so those of us who live
> > in our email clients could have reviewed it...
> 
> Next time I'll try to split it up in managable parts, and send it
> inline.

I, and others, will appreciate that.

thanks,

greg k-h
