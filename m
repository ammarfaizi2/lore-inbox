Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265101AbRGAL1B>; Sun, 1 Jul 2001 07:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265103AbRGAL0v>; Sun, 1 Jul 2001 07:26:51 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:23623 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S265101AbRGAL0g>;
	Sun, 1 Jul 2001 07:26:36 -0400
Message-ID: <20010701132639.A27154@win.tue.nl>
Date: Sun, 1 Jul 2001 13:26:39 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: Joseph Carter <knghtbrd@d2dc.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Mac USB keyboards (Was: USB Keyboard errors with 2.4.5-ac)
In-Reply-To: <20010701020758.B26841@win.tue.nl> <20010630180859.A5557@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010630180859.A5557@debian.org>; from Joseph Carter on Sat, Jun 30, 2001 at 06:08:59PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2001 at 06:08:59PM -0700, Joseph Carter wrote:

> > To understand the details of the code, trace the steps:
> > (i)  The USB code can be found e.g. on
> > 	http://www.win.tue.nl/~aeb/linux/kbd/scancodes-5.html
> > We find that Power is 102 and that Keypad-= is 103.
> 
> I find that KP = can also be 134, according to this.

Yes. The USB spec says for this code: "used on AS/400 keyboards".
