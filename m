Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265038AbRGBWYK>; Mon, 2 Jul 2001 18:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265461AbRGBWYB>; Mon, 2 Jul 2001 18:24:01 -0400
Received: from mail-smtp.socket.net ([216.106.1.32]:25872 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S265457AbRGBWXw>; Mon, 2 Jul 2001 18:23:52 -0400
Date: Mon, 2 Jul 2001 17:23:40 -0500
From: "Gregory T. Norris" <haphazard@socket.net>
To: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
Cc: linux-usb-devel@lists.sourceforge.net,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: usbserial/keyspan module load race [was: 2.4.5 keyspan driver]
Message-ID: <20010702172340.B2463@glitch.snoozer.net>
Mail-Followup-To: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>,
	linux-usb-devel@lists.sourceforge.net,
	linux-kernel <linux-kernel@vger.redhat.com>
In-Reply-To: <20010630003323.A908@glitch.snoozer.net> <20010630133752.A850@glitch.snoozer.net> <20010701154910.A15335@glitch.snoozer.net> <01070123350102.05063@idun>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01070123350102.05063@idun>
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux glitch 2.4.5 #1 Sat Jun 30 17:26:00 CDT 2001 i686 unknown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried it both ways.  It didn't seem to make any difference.

On Sun, Jul 01, 2001 at 11:35:01PM +0200, Oliver Neukum wrote:
> Most interresting.
> 
> Did you compile with generic serial device support ?
> Could you please reverse your configuration choice in this regard and try 
> reproduce it ?
> 
> 	Regards
> 		Oliver
> 
> 
