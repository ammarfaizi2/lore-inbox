Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272322AbRIPOu5>; Sun, 16 Sep 2001 10:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272324AbRIPOur>; Sun, 16 Sep 2001 10:50:47 -0400
Received: from mx2.port.ru ([194.67.57.12]:15377 "EHLO smtp2.port.ru")
	by vger.kernel.org with ESMTP id <S272322AbRIPOud>;
	Sun, 16 Sep 2001 10:50:33 -0400
Date: Sun, 16 Sep 2001 18:56:04 +0400
From: Nick Kurshev <nickols_k@mail.ru>
To: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.9-ac10
Message-Id: <20010916185604.6d63a1bb.nickols_k@mail.ru>
In-Reply-To: <3BA48452.653466D4@kolumbus.fi>
In-Reply-To: <20010908005500.A11127@lightning.swansea.linux.org.uk>
	<3BA48452.653466D4@kolumbus.fi>
X-Mailer: Sylpheed version 0.6.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Jussi!
On Sun, 16 Sep 2001 13:52:02 +0300, you wrote:

> Hello,
> 
> Alan Cox wrote:
> > 
> > o       Recognize Radeon VE in radeonfb                 (Nick Kurshev)
> 
> This doesn't work for me. Now the video signal goes off (and stays) at boot.
> Kernel continues booting, but I can't see anything.
> 
> This is probably the same software reset thing as with XFree86 driver.
> 
This driver works in the same way as XFree86 - i.e. through DVI port only.
CRT port currently is not supported. But its support is already implemented
in XFree86-CVS and maybe I'll add it to radeonfb (but not soon).
> Best regards,
> 
> 	- Jussi Laako
> 
> -- 
> PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
> Available at PGP keyservers
> 


Best regards! Nick
