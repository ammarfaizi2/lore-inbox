Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266893AbUHCVtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266893AbUHCVtS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 17:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266890AbUHCVtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 17:49:17 -0400
Received: from mail.kroah.org ([69.55.234.183]:19351 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266894AbUHCVtA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 17:49:00 -0400
Date: Tue, 3 Aug 2004 06:57:30 -0700
From: Greg KH <greg@kroah.com>
To: Luis Miguel Garc?a Mancebo <ktech@wanadoo.es>
Cc: LKML <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: USB troubles in rc2
Message-ID: <20040803135730.GB13390@kroah.com>
References: <200408022100.54850.ktech@wanadoo.es> <20040803002634.GB26323@kroah.com> <200408031046.57137.ktech@wanadoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408031046.57137.ktech@wanadoo.es>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2004 at 10:46:57AM +0200, Luis Miguel Garc?a Mancebo wrote:
> With 2.6.7-mm7 don't work either, but I can revert the bk-usb.patch in the 
> andrew tree and all works ok. Even the camera:

So 2.6.7 (with no patches) worked for you?  Did 2.6.8-rc1 break?  Or was
it 2.6.8-rc2 that broke your box?

thanks,

greg k-h
