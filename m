Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264658AbUHCA2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264658AbUHCA2r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 20:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264655AbUHCA2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 20:28:46 -0400
Received: from mail.kroah.org ([69.55.234.183]:39899 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264658AbUHCA1P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 20:27:15 -0400
Date: Mon, 2 Aug 2004 17:26:34 -0700
From: Greg KH <greg@kroah.com>
To: Luis Miguel Garc?a Mancebo <ktech@wanadoo.es>
Cc: LKML <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: USB troubles in rc2
Message-ID: <20040803002634.GB26323@kroah.com>
References: <200408022100.54850.ktech@wanadoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408022100.54850.ktech@wanadoo.es>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2004 at 09:00:54PM +0200, Luis Miguel Garc?a Mancebo wrote:
> Hello,
> 
> 	I have a nforce2 motherboard. I have to report that recent changes in usb 
> code make my board don't work at all.
> 
> 	In 2.6.7-mm7, I just reverted the bk-usb.patch and the things started to 
> work, but now it's on mainstream, so I cannot make it work.
> 
> 	Do you want for me to do some tests?

Yes please.  What exactly "does not work"?

Also, let's cc: the linux-usb-devel mailing list to try to help out
here...

thanks,

greg k-h
