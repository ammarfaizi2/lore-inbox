Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266254AbRF3Sj3>; Sat, 30 Jun 2001 14:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266253AbRF3SjK>; Sat, 30 Jun 2001 14:39:10 -0400
Received: from mail-smtp.socket.net ([216.106.1.32]:46096 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S266252AbRF3SjB>; Sat, 30 Jun 2001 14:39:01 -0400
Date: Sat, 30 Jun 2001 13:37:52 -0500
From: "Gregory T. Norris" <haphazard@socket.net>
To: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-usb-users@lists.sourceforge.net
Subject: Re: 2.4.5 keyspan driver
Message-ID: <20010630133752.A850@glitch.snoozer.net>
Mail-Followup-To: linux-kernel <linux-kernel@vger.redhat.com>,
	linux-usb-users@lists.sourceforge.net
In-Reply-To: <20010630003323.A908@glitch.snoozer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010630003323.A908@glitch.snoozer.net>
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux glitch 2.4.5 #1 Sat Jun 30 12:19:22 CDT 2001 i686 unknown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems to be working now, although I'm not really sure what fixed
it... my kernel configuration is essentially unchanged.  I'm suspicious
that the adapter might have a bad connection, or something similar.

Cheers!

On Sat, Jun 30, 2001 at 12:33:23AM -0500, Gregory T. Norris wrote:
> I'm trying to use a Keyspan USA-19 to enable access to a Palm m500 on a
> serial cradle.  Whenever I try to modprobe the keyspan module I get the
> message "Warning: /lib/modules/2.4.5/kernel/drivers/usb/serial/usbserial.o
> symbol for parameter vendor not found"... the module loads anyway, but
> doesn't seem to detect the device.
> 
> As far as I can see, everything seems to be setup correctly (.config
> attached).  Pointers and suggestions would be greatly appreciated.
> Thanx!
