Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132555AbRDAVA5>; Sun, 1 Apr 2001 17:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132557AbRDAVAq>; Sun, 1 Apr 2001 17:00:46 -0400
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:14925 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S132555AbRDAVAd>; Sun, 1 Apr 2001 17:00:33 -0400
Date: Sun, 1 Apr 2001 15:59:34 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: lm@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: bug database braindump from the kernel summit
In-Reply-To: <001c01c0bae2$e523fc90$5517fea9@local>
Message-ID: <Pine.LNX.3.96.1010401155736.28121J-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Apr 2001, Manfred Spraul wrote:
> > There was a lot of discussion about possible tools
> > that would dig out the /proc/pci info
> 
> I think the tools should not dig too much information out of the system.
> I remember some Microsoft (win98 beta?) bugtracking software that
> insisted on sending a several hundert kB long compressed blob with every
> bug report.
> IMHO it must be possible to file bugreports without the complete hw info
> if I know that the bug isn't hw related.

Two comments --
* It's only disk space.  It's better to have and not need, than need and
  not have.  Please do give me 200kb bug reports!  :)
* There should be a way to allow the user to omit hw info, because the
  user may not want to disclose some parts of their system.

Regards,

	Jeff




