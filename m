Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261698AbVCRQt1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbVCRQt1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 11:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbVCRQt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 11:49:27 -0500
Received: from mail.kroah.org ([69.55.234.183]:4502 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261698AbVCRQtW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 11:49:22 -0500
Date: Fri, 18 Mar 2005 08:49:11 -0800
From: Greg KH <gregkh@suse.de>
To: Simon Geard <simon@whiteowl.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB pen drive connect/disconnect oops
Message-ID: <20050318164911.GB14952@kroah.com>
References: <423A9856.7070909@whiteowl.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <423A9856.7070909@whiteowl.co.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2005 at 08:59:02AM +0000, Simon Geard wrote:
> When I connect and disconnect my new USB Pen drive (BAR 512MB) I get 
> stack dump messages from the kernel. The drive does seem to be usable at 
> the end of this sequence albeit very slowly. Disconnection gives a 
> kernel oops and the device isn't usable until the next reboot. Does 
> anyone know if there is a patch to fix this problem?
> 
> Please cc any replies to me. Thanks
> 
> Simon Geard
> 
> Linux localhost 2.6.8.1-12mdk #1 Fri Oct 1 12:53:41 CEST 2004 i686 

Please try the 2.6.11 kernel release, this should be fixed there.

thanks,

greg k-h
