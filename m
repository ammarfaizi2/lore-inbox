Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317096AbSH0Tcq>; Tue, 27 Aug 2002 15:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317101AbSH0Tcp>; Tue, 27 Aug 2002 15:32:45 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:45067 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317096AbSH0Tcp>;
	Tue, 27 Aug 2002 15:32:45 -0400
Date: Tue, 27 Aug 2002 12:36:32 -0700
From: Greg KH <greg@kroah.com>
To: Felix Seeger <felix.seeger@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB mouse problem, kernel panic on startup in 2.4.19
Message-ID: <20020827193632.GD23865@kroah.com>
References: <200208272011.51691.felix.seeger@gmx.de> <200208272023.52351.felix.seeger@gmx.de> <20020827183119.GB23700@kroah.com> <200208272130.14728.felix.seeger@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208272130.14728.felix.seeger@gmx.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2002 at 09:30:11PM +0200, Felix Seeger wrote:
> No, sorry. Doesn't help.
> Is that a patch for 2.4.20-pre4 ? I am using 2.4.19.

Yes it is, but it might apply to 2.4.19.  I am guessing you tried it,
and it applied cleanly?  Any build errors?

> Oh, the shift and the numlock leds are blinking.

That means the kernel paniced :)

thanks,

greg k-h
