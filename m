Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422784AbWHEJet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422784AbWHEJet (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 05:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422785AbWHEJet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 05:34:49 -0400
Received: from toplitzer.net ([83.151.30.110]:43473 "EHLO toplitzer.net")
	by vger.kernel.org with ESMTP id S1422784AbWHEJes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 05:34:48 -0400
From: Helmut <bgrpt@toplitzer.net>
To: Greg KH <greg@kroah.com>
Subject: Re: pci=assign-busses output and problems
Date: Sat, 5 Aug 2006 11:34:40 +0200
User-Agent: KMail/1.7.2
References: <200608031204.56842.bgrpt@toplitzer.net> <20060805064123.GB25389@kroah.com>
In-Reply-To: <20060805064123.GB25389@kroah.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608051134.41488.bgrpt@toplitzer.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > Attaching pci-assign-busses.txt with output and a output of dmesg before
> > using this option.
>
> Which device is being hidden here?  

Good question. It's a Toshiba Tecra S1 with SD-card reader, 2 PCMCIA, 
DVD/CDRW drive, modem, ipw2200, ...

Maybe it's the card reader, never used it. That's why I attached
both dmesg outputs; thought you can find the info in there.

> And if everything is working 
> properly, I wouldn't worry much about it :)

It's working as long pci=assign-busses is not used. (Can't tell for
sure for the card reader)

I'm having a problem with ipw2200 which is currently dealt with by the 
maintainers of this modules. If it has nothing to do with it just 
ignore this because I was just doing what the kernel told me to do ;-)


thanks,
Helmut

