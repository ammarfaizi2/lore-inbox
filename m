Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbVIZMhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbVIZMhi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 08:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbVIZMhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 08:37:38 -0400
Received: from [85.21.88.2] ([85.21.88.2]:36317 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S932111AbVIZMhi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 08:37:38 -0400
Subject: Re: [spi-devel-general] Re: SPI
From: dmitry pervushin <dpervushin@gmail.com>
To: Eric Piel <Eric.Piel@tremplin-utc.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       spi-devel-general@lists.sourceforge.net
In-Reply-To: <4337EA12.1070001@tremplin-utc.net>
References: <1127733134.7577.0.camel@diimka.dev.rtsoft.ru>
	 <4337EA12.1070001@tremplin-utc.net>
Content-Type: text/plain
Date: Mon, 26 Sep 2005 16:37:36 +0400
Message-Id: <1127738256.7577.3.camel@diimka.dev.rtsoft.ru>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1-1mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-26 at 14:31 +0200, Eric Piel wrote:
> > +	  Say Y if you need to enable SPI support on your kernel
> SPI is far from being well know, please put more help. At least define 
> SPI as "Serial Peripheral Interface" and suggest the user to have a look 
> at Documentation/spi.txt . IMHO, it's also convenient if you give the 
> name of the module that will be created (spi?).
The module name is spi-core. If one who configures the kernel does not
know about the SPI, it seems that it is better to keep the option
unchanged... However, I edit the text in Kconfig.
> Broken link, it is 
> http://en.wikipedia.org/wiki/Serial_Peripheral_Interface (no trailing /)
Fixed.

Thank you for comments,
dmitry 

