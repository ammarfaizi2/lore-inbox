Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269136AbRG3Wxh>; Mon, 30 Jul 2001 18:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269121AbRG3Wx1>; Mon, 30 Jul 2001 18:53:27 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:10504 "HELO dvmwest.gt.owl.de")
	by vger.kernel.org with SMTP id <S269092AbRG3WxH>;
	Mon, 30 Jul 2001 18:53:07 -0400
Date: Tue, 31 Jul 2001 00:53:14 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Linux kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Support for serial console on legacy free machines
Message-ID: <20010731005314.D19713@lug-owl.de>
Mail-Followup-To: Linux kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <3B65D3DA.D70B48A0@fc.hp.com> <200107302240.f6UMeWg2001230@webber.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200107302240.f6UMeWg2001230@webber.adilger.int>; from adilger@turbolinux.com on Mon, Jul 30, 2001 at 04:40:31PM -0600
X-Operating-System: Linux mail 2.4.5 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, Jul 30, 2001 at 04:40:31PM -0600, Andreas Dilger wrote:
> There was some talk about using a low level IP console over ethernet,
> but I would imagine this is more complex than the same thing on a
> parallel-port.  I could be wrong.  Of course, an IP console has the
> advantage of being useful over a longer distance than a parallel cable,
> but may have the disadvantage of poor security.

Well, you could use IP (If you use IP autoconfig you could even
route it), but also a proprietary protocol like MOP did centuries
ago. That would only give you access as long as you've on the
same physical network.

However - I'd love to see a networked console.

MfG, JBG
PS: And I'd like to see ~22 Am7990 Lance drivers to go away!!! Bloat...

