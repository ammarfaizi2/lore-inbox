Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262723AbTDKXyX (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 19:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262727AbTDKXyX (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 19:54:23 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:50583 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262723AbTDKXyW (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 19:54:22 -0400
Date: Fri, 11 Apr 2003 17:03:57 -0700
From: Greg KH <greg@kroah.com>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: USB Keyboard in 2.5 bitkeeper...
Message-ID: <20030412000357.GJ4539@kroah.com>
References: <200304111941.16563.ivg2@cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304111941.16563.ivg2@cornell.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 07:41:08PM -0400, Ivan Gyurdiev wrote:
> input1: USB HID v1.00 Keyboard [NOVATEK Keyboard NT6881] on usb1:3.0
> input2: USB HID v1.00 Mouse [NOVATEK Keyboard NT6881] on usb1:3.1
> 
> That's only a keyboard, but interestingly it shows up as a keyboard AND mouse.
> (This kernel is 2.4.21-pre5-ac3)

Well, it thinks it is both :)

> Anyway: In 2.5 bitkeeper (4/11/03), my keyboard is completely dead - even 
> sysrq doesn't work. I've had similar problems with recent 2.4 bitkeeper 
> kernels (but I can't be very specific - I can re-test if you'd like me to)

Does 2.5.67 work for you?

thanks,

greg k-h
