Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265488AbRGBXeY>; Mon, 2 Jul 2001 19:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265494AbRGBXeO>; Mon, 2 Jul 2001 19:34:14 -0400
Received: from mail-smtp.socket.net ([216.106.1.32]:27140 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S265488AbRGBXd6>; Mon, 2 Jul 2001 19:33:58 -0400
Date: Mon, 2 Jul 2001 18:33:50 -0500
From: "Gregory T. Norris" <haphazard@socket.net>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: usbserial/keyspan module load race [was: 2.4.5 keyspan driver]
Message-ID: <20010702183350.A1451@glitch.snoozer.net>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	linux-kernel <linux-kernel@vger.redhat.com>
In-Reply-To: <20010630003323.A908@glitch.snoozer.net> <20010630133752.A850@glitch.snoozer.net> <20010701154910.A15335@glitch.snoozer.net> <01070200025204.05063@idun> <20010702172217.A2463@glitch.snoozer.net> <20010702154325.B25063@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010702154325.B25063@kroah.com>
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux glitch 2.4.5 #1 Sat Jun 30 17:26:00 CDT 2001 i686 unknown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

adric@glitch[~]$ dpkg -l modutils | tail -n1
ii  modutils       2.4.6-3        Linux module utilities.


On Mon, Jul 02, 2001 at 03:43:25PM -0700, Greg KH wrote:
> What version of the modutils package do you have?
> 
> thanks,
> 
> greg k-h
