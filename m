Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265091AbRGBW1k>; Mon, 2 Jul 2001 18:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264635AbRGBW1a>; Mon, 2 Jul 2001 18:27:30 -0400
Received: from mail-smtp.socket.net ([216.106.1.32]:21265 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S265457AbRGBW1P>; Mon, 2 Jul 2001 18:27:15 -0400
Date: Mon, 2 Jul 2001 17:26:26 -0500
From: "Gregory T. Norris" <haphazard@socket.net>
To: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-usb-users@lists.sourceforge.net
Subject: Re: usbserial/keyspan module load race [was: 2.4.5 keyspan driver]
Message-ID: <20010702172626.C2463@glitch.snoozer.net>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>,
	linux-usb-users@lists.sourceforge.net
In-Reply-To: <20010630003323.A908@glitch.snoozer.net> <20010630133752.A850@glitch.snoozer.net> <20010701154910.A15335@glitch.snoozer.net> <20010701195128.A21973@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010701195128.A21973@kroah.com>
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux glitch 2.4.5 #1 Sat Jun 30 17:26:00 CDT 2001 i686 unknown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Which keyspan driver are you doing this with, keyspan_pda.o or
> keyspan.o?

keyspan.o

> Have you tried having the linux-hotplug scripts install the driver for
> you when you plug the device in? <http://linux-hotplug.sourceforge.net/>

Not yet.  It's on my to-do list, tho. (-:
