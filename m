Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276600AbRJGTSt>; Sun, 7 Oct 2001 15:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276601AbRJGTS3>; Sun, 7 Oct 2001 15:18:29 -0400
Received: from h24-78-175-24.vn.shawcable.net ([24.78.175.24]:2432 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S276600AbRJGTSZ>;
	Sun, 7 Oct 2001 15:18:25 -0400
Date: Sun, 7 Oct 2001 12:18:51 -0700
From: Simon Kirby <sim@netnation.com>
To: Greg KH <greg@kroah.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.11-pre5
Message-ID: <20011007121851.A1137@netnation.com>
In-Reply-To: <Pine.LNX.4.33.0110071148380.7382-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0110071148380.7382-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 07, 2001 at 11:49:46AM -0700, Linus Torvalds wrote:

> pre5:
>  - Greg KH: USB update

This appears to break my Logitech optical mouse with uhci.  usb-uhci
works fine.

hub.c: USB new device connect on bus1/2, assigned device number 2
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=2 (error=-110)

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
