Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278807AbRJVNtx>; Mon, 22 Oct 2001 09:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278806AbRJVNtn>; Mon, 22 Oct 2001 09:49:43 -0400
Received: from ns.suse.de ([213.95.15.193]:1289 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S278804AbRJVNtf>;
	Mon, 22 Oct 2001 09:49:35 -0400
Date: Mon, 22 Oct 2001 15:50:08 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: USB module ov511 dies after about 30 minutes
In-Reply-To: <20011022154537.53c54bf3.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.30.0110221547290.11628-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2001, Stephan von Krawczynski wrote:

> > > about 30 minutes the module ov511 cannot be unloaded anymore, stopped
> > > working
> Sorry, tested but does not work either. It even hangs the system sometimes. Of
> course it did with former kernels. Any other ideas?

Remind me, what kernel version was this ? Until 2.4.12 iirc usb-uhci had
problems with ov511. Using the alternative uhci driver may also be
something worth trying. Other than that, I'm out of ideas. USB gurus ?

regards,

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

