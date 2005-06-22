Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261633AbVFVQr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261633AbVFVQr0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 12:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbVFVQrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 12:47:25 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:65036 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261633AbVFVQoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 12:44:38 -0400
Date: Wed, 22 Jun 2005 18:44:36 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: George Kasica <georgek@netwrx1.com>, linux-kernel@vger.kernel.org
Subject: Re: Problem compiling 2.6.12
Message-ID: <20050622164436.GI3705@stusta.de>
References: <Pine.LNX.4.62.0506221026130.4837@eagle.netwrx1.com> <9a874849050622085975b67c06@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a874849050622085975b67c06@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 05:59:45PM +0200, Jesper Juhl wrote:
> 
> Don't use a 2.4.x config as the basis for a 2.6.x kernel .
> Build your first 2.6.x kernel config using "make menuconfig", "make
> config", make xconfig" or similar, /then/ you can use that config in
> the future as a base for other 2.6.x kernels with "make oldconfig".

First of all, this shouldn't result in problems like the one he 
reported (see my other mail).

And I'm surprised you are saying this. I'd have expected that running 
"make oldconfig" with a 2.4 kernel should give him a working 
configuration.

Can you explain where you'd expect problems so that we can fix them?

> Jesper Juhl <jesper.juhl@gmail.com>

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

