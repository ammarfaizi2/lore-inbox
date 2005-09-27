Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964882AbVI0O1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbVI0O1Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 10:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbVI0O1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 10:27:23 -0400
Received: from [85.21.88.2] ([85.21.88.2]:27879 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S964882AbVI0O1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 10:27:23 -0400
Subject: Re: [spi-devel-general] Re: SPI
From: dmitry pervushin <dpervushin@gmail.com>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       spi-devel-general@lists.sourceforge.net
In-Reply-To: <20050927124335.GA10361@kroah.com>
References: <1127733134.7577.0.camel@diimka.dev.rtsoft.ru>
	 <20050927124335.GA10361@kroah.com>
Content-Type: text/plain
Date: Tue, 27 Sep 2005 18:27:16 +0400
Message-Id: <1127831236.7577.33.camel@diimka.dev.rtsoft.ru>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1-1mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-27 at 05:43 -0700, Greg KH wrote:
> This is ALWAYS wrong, please fix your code.  See the many times I have
> been over this issue in the archives.
Do you mean this comment ? The spi_device_release does nothing, just to
prevent compains from device_release function :)
> 
> Also, please fix your coding style to match the kernel if you wish to
> have a chance to get it included. :)
Hmm... running Lindent... done. Thank you once more, for your valuable
comments :)


