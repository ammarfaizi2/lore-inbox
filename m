Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271375AbTHHPFp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 11:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271378AbTHHPFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 11:05:45 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:20137 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S271375AbTHHPFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 11:05:38 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Fri, 8 Aug 2003 17:05:36 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: akpm@osdl.org, andrea@suse.de, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
Message-Id: <20030808170536.23118033.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.44.0308081151330.8204-100000@logos.cnet>
References: <20030808002918.723abb08.skraw@ithnet.com>
	<Pine.LNX.4.44.0308081151330.8204-100000@logos.cnet>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Aug 2003 11:54:39 -0300 (BRT)
Marcelo Tosatti <marcelo@conectiva.com.br> wrote:

> > I can give you this additional info:
> > I tried about everything back to 2.4.21 release, and even this crashes on
> > the box. BUT it is _not_ the only box I can crash 2.4.21. I have another
> > hardware(also SMP) based not on Serverworks but on VIA chipset and with no
> > 64 bit pci and it crashes with 2.4.21 around every 10 - 20 days. It
> > definitely does not with 2.4.19. 
> 
> Do you have any traces of the other box crash? 

Not at hand, but can prepare for the next crash during the weekend.

> > The only requirement for my usual test-box is a working tg3 driver for the
> > GBit ethernet link.
> 
> > Ah yes, and from the long series of tests I can tell that the box won't
> > crash with UP kernel. I can re-check that with rc1 if this is useful.
> 
> Okey. Thats useful information. How hard would it be for you to try ext3 
> as the filesystem (as Andrew suggested) ? 

Well, if that provides further info I will do. I will try to achieve over the
weekend, I need some spare volumes for conversion (by copy) :-)

Regards,
Stephan
