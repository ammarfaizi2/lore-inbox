Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265682AbRGCRjx>; Tue, 3 Jul 2001 13:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265545AbRGCRjd>; Tue, 3 Jul 2001 13:39:33 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:37132 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265478AbRGCRjV>;
	Tue, 3 Jul 2001 13:39:21 -0400
Date: Tue, 3 Jul 2001 10:38:00 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-usb-users@lists.sourceforge.net
Subject: Re: 2.4.5 keyspan driver
Message-ID: <20010703103800.B28180@kroah.com>
In-Reply-To: <20010630003323.A908@glitch.snoozer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010630003323.A908@glitch.snoozer.net>; from haphazard@socket.net on Sat, Jun 30, 2001 at 12:33:23AM -0500
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2001 at 12:33:23AM -0500, Gregory T. Norris wrote:
> CONFIG_USB_SERIAL=m
> # CONFIG_USB_SERIAL_GENERIC is not set

Can you enable CONFIG_USB_SERIAL_GENERIC and let me know if that fixes
the problem?

thanks,

greg k-h
