Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272176AbRH3OWT>; Thu, 30 Aug 2001 10:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272226AbRH3OWJ>; Thu, 30 Aug 2001 10:22:09 -0400
Received: from mail.scs.ch ([212.254.229.5]:36868 "EHLO mail.scs.ch")
	by vger.kernel.org with ESMTP id <S272176AbRH3OV6>;
	Thu, 30 Aug 2001 10:21:58 -0400
Message-ID: <3B8E4C0A.6150C0CB@scs.ch>
Date: Thu, 30 Aug 2001 16:22:02 +0200
From: Thomas Sailer <sailer@scs.ch>
Reply-To: t.sailer@alumni.ethz.ch
Organization: SCS
X-Mailer: Mozilla 4.77 [de] (X11; U; Linux 2.4.3-13jnx i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Sam Halliday <plendily@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: usbdevfs timeout
In-Reply-To: <F49zyWR4Atg2c7qIA3E000030b1@hotmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Halliday schrieb:

> 1- when i attach the rio i get this error (which i ignore because i am not
> using any driver anyway, but it is inconvenient that it pops up every time)
> "usb.c: USB device 3 (vend/prod 0x45a/0x5001) is not claimed by any active
> driver"

This is normal (not an error), as there is no kernel driver for the rio

Tom
