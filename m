Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbVC0Sfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbVC0Sfy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 13:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbVC0Sfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 13:35:53 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:65294 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261387AbVC0Sf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 13:35:26 -0500
Date: Sun, 27 Mar 2005 20:35:22 +0200
From: Adrian Bunk <bunk@stusta.de>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Arjan van de Ven <arjan@infradead.org>,
       Aaron Gyes <floam@sh.nu>, linux-kernel@vger.kernel.org
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
Message-ID: <20050327183522.GM4285@stusta.de>
References: <1111886147.1495.3.camel@localhost> <490243b66dc7c3f592df7a7d0769dcb7@mac.com> <1111913399.6297.28.camel@laptopd505.fenrus.org> <16d78e9ea33380a1f1ad90c454fb6e1d@mac.com> <20050327180417.GD3815@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050327180417.GD3815@gallifrey>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2005 at 07:04:17PM +0100, Dr. David Alan Gilbert wrote:
> * Kyle Moffett (mrmacman_g4@mac.com) wrote:
> 
> > <flame type="Binary Driver Hatred">
> > NOTE: I *strongly* discourage binary drivers.  They're crap and 
> > frustrate poor PowerPC users like me.
> 
> I mostly agree - there is one case where I think they *might*
> be acceptable; (and I think the original poster *may* fall
> into this category).
> 
> If you are making a very specialist piece of equipment; not
> the type of thing you can go and plug into any old PC; but
> say an entire box with some obscure piece of hardware in
> that no one would want to buy as a seperate add on. I just
> don't see the need to force someone to make drivers for
> this type of thing public.
>...

And then the user want to upgrade the 2.0 kernel that shipped with this 
box although the company that made the hardware went bankrupt some years 
ago.

If the user has the source of the driver, he can port the driver or hire 
someone to port the driver (this "obscure piece of hardware" might also 
be an expensive piece of hardware).

Or if the driver is in the kernel sources, it might have even been 
ported.

> Dave

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

