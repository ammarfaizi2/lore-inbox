Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbVAZXWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbVAZXWv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 18:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261591AbVAZXVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:21:33 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:38148 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261599AbVAZSTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 13:19:43 -0500
Date: Wed, 26 Jan 2005 19:19:41 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: dtor_core@ameritech.net, Christoph Hellwig <hch@infradead.org>,
       Jean Delvare <khali@linux-fr.org>, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc2-mm1: SuperIO scx200 breakage
Message-ID: <20050126181941.GC5297@stusta.de>
References: <20050124214751.GA6396@infradead.org> <20050125060256.GB2061@kroah.com> <20050125195918.460f2b10.khali@linux-fr.org> <20050126003927.189640d4@zanzibar.2ka.mipt.ru> <20050125224051.190b5ff9.khali@linux-fr.org> <20050126013556.247b74bc@zanzibar.2ka.mipt.ru> <20050126101434.GA7897@infradead.org> <1106737157.5257.139.camel@uganda> <d120d5000501260600fb8589e@mail.gmail.com> <1106757528.5257.221.camel@uganda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106757528.5257.221.camel@uganda>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2005 at 07:38:48PM +0300, Evgeniy Polyakov wrote:
>...
> Btw, where was comments about w1, kernel connector and acrypto? 
> They were presented several times in lkml and all are completely new
> subsystems.
> Should I stop developing just because I did not get comments?
>...

I sent you comments regarding w1 two months ago regarding:
- the unneeded dscore -> ds9490r rename in the Makefile
- completely unused EXPORT_SYMBOL's (that seem to be still unused today)

Being honest, I have to admit that your reactions didn't sound as if you 
were waiting for comments.

> Thank you.
> 
>         Evgeniy Polyakov

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

