Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266037AbRGCWU7>; Tue, 3 Jul 2001 18:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266042AbRGCWUs>; Tue, 3 Jul 2001 18:20:48 -0400
Received: from mail-smtp.socket.net ([216.106.1.32]:48645 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S266037AbRGCWUk>; Tue, 3 Jul 2001 18:20:40 -0400
Date: Tue, 3 Jul 2001 17:19:53 -0500
From: "Gregory T. Norris" <haphazard@socket.net>
To: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-usb-users@lists.sourceforge.net
Subject: Re: 2.4.5 keyspan driver
Message-ID: <20010703171953.A16664@glitch.snoozer.net>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>,
	linux-usb-users@lists.sourceforge.net
In-Reply-To: <20010630003323.A908@glitch.snoozer.net> <20010703103800.B28180@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010703103800.B28180@kroah.com>
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux glitch 2.4.5 #1 Sat Jun 30 17:26:00 CDT 2001 i686 unknown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm pretty sure that I've hit this with CONFIG_USB_SERIAL_GENERIC set. 
I'll retry it, just to be sure.

On Tue, Jul 03, 2001 at 10:38:00AM -0700, Greg KH wrote:
> On Sat, Jun 30, 2001 at 12:33:23AM -0500, Gregory T. Norris wrote:
> > CONFIG_USB_SERIAL=m
> > # CONFIG_USB_SERIAL_GENERIC is not set
> 
> Can you enable CONFIG_USB_SERIAL_GENERIC and let me know if that fixes
> the problem?
> 
> thanks,
> 
> greg k-h
