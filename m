Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbTDMAoH (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 20:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262639AbTDMAoG (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 20:44:06 -0400
Received: from postoffice2.mail.cornell.edu ([132.236.56.10]:4028 "EHLO
	postoffice2.mail.cornell.edu") by vger.kernel.org with ESMTP
	id S262633AbTDMAoF (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 20:44:05 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
Organization: ( )
To: Greg KH <greg@kroah.com>
Subject: Re: USB Keyboard in 2.5 bitkeeper...
Date: Sat, 12 Apr 2003 20:57:19 -0400
User-Agent: KMail/1.5
References: <200304111941.16563.ivg2@cornell.edu> <20030412000357.GJ4539@kroah.com>
In-Reply-To: <20030412000357.GJ4539@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304122057.19381.ivg2@cornell.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 April 2003 20:03, you wrote:
> On Fri, Apr 11, 2003 at 07:41:08PM -0400, Ivan Gyurdiev wrote:
> > input1: USB HID v1.00 Keyboard [NOVATEK Keyboard NT6881] on usb1:3.0
> > input2: USB HID v1.00 Mouse [NOVATEK Keyboard NT6881] on usb1:3.1
> >
> > That's only a keyboard, but interestingly it shows up as a keyboard AND
> > mouse. (This kernel is 2.4.21-pre5-ac3)
>
> Well, it thinks it is both :)
>
> > Anyway: In 2.5 bitkeeper (4/11/03), my keyboard is completely dead - even
> > sysrq doesn't work. I've had similar problems with recent 2.4 bitkeeper
> > kernels (but I can't be very specific - I can re-test if you'd like me
> > to)
>
> Does 2.5.67 work for you?

I can't test it - it oopses... 

I'll try some more kernels when I have a little bit more time...
and I'll report back.


