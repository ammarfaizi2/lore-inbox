Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267520AbSLLVWa>; Thu, 12 Dec 2002 16:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267519AbSLLVVf>; Thu, 12 Dec 2002 16:21:35 -0500
Received: from postfix4-2.free.fr ([213.228.0.176]:21399 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP
	id <S267518AbSLLVVS>; Thu, 12 Dec 2002 16:21:18 -0500
Date: Thu, 12 Dec 2002 22:29:04 +0100
From: Romain Lievin <roms@tilp.info>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: kconfig (gkc) [PATCH]
Message-ID: <20021212212904.GA8103@free.fr>
References: <20021110132750.GB6256@free.fr> <Pine.LNX.4.44.0211101502460.2113-100000@serv> <20021128091059.GB388@free.fr> <Pine.LNX.4.44.0211281204030.2113-100000@serv> <20021128141223.GA601@free.fr> <Pine.LNX.4.44.0211282111110.2113-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211282111110.2113-100000@serv>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry, for the long time, I was waiting for GTK+ team to fix a bug...

> > BTW, I have fixed the problems you reported to me in gkc (gconf). gkc is now
> > working fine. 
> 
> I still saw some problems, e.g. try to play with SCSI_AIC7XXX.

Well, fixed... All stuffs seem to work fine now !

> A seperate target should do for now. I'm a bit concerned about the size. I 
> tried to keep qconf small, so e.g. I didn't use the qt designer. gconf is 
> now already larger than qconf. It might help to see it as complete patch 
> and if not too many people complain, it would be far easier for me to send 
> it on to Linus. :)

You will find a patch against 2.5.51 on http://tilp.info/perso/gkc.html.

> 
> bye, Roman
> 
> 

Next step: add the 2 other views and use icons (by sharing yours).

Thanks, Romain.
-- 
Romain Lievin, aka 'roms'  	<roms@tilp.info>
The TiLP project is on 		<http://www.ti-lpg.org>
"Linux, y'a moins bien mais c'est plus cher !"














