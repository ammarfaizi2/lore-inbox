Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269752AbTGKBfw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 21:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269754AbTGKBfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 21:35:52 -0400
Received: from storm.he.net ([64.71.150.66]:45469 "HELO storm.he.net")
	by vger.kernel.org with SMTP id S269752AbTGKBfr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 21:35:47 -0400
Date: Thu, 10 Jul 2003 18:50:29 -0700
From: Greg KH <greg@kroah.com>
To: imunity@softhome.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB-UHCI Fatal Error for all 2.5 kernels and 2.5.75 in RedHat v9.0
Message-ID: <20030711015029.GA15893@kroah.com>
References: <courier.3F0E130B.000035DE@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <courier.3F0E130B.000035DE@softhome.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 10, 2003 at 07:29:47PM -0600, imunity@softhome.net wrote:
> 
> For soem reason right after the boot of the 2.5 kernels right when the INIT 
> starts the USB-UHCI fails for  the HID devices. 

Exactly what error are you getting in the kernel log?

greg k-h
