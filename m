Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285327AbRLGAAh>; Thu, 6 Dec 2001 19:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285326AbRLGAA1>; Thu, 6 Dec 2001 19:00:27 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:57604 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285325AbRLGAAS>; Thu, 6 Dec 2001 19:00:18 -0500
Subject: Re: Linux 2.4.17-pre5
To: davej@suse.de (Dave Jones)
Date: Fri, 7 Dec 2001 00:09:12 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        marcelo@conectiva.com.br (Marcelo Tosatti),
        linux-kernel@vger.kernel.org (lkml),
        torvalds@transmeta.com (Linus Torvalds)
In-Reply-To: <Pine.LNX.4.33.0112070033450.4486-100000@Appserv.suse.de> from "Dave Jones" at Dec 07, 2001 12:38:12 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16C8Zk-0003if-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Actually that one is  various Intel people not me 8)
> 
> Wouldn't it be better to see such things proven right in 2.5 first ?

o	2.5 isnt going to be usable for that kind of thing in the near future
o	There is no code that is "new" for normal paths (in fact Marcelo
	wanted a change for the only "definitely harmless" one there was)
> 
> Random things like this still appearing in 2.4 that haven't shown
> up in 2.5 yet is a little disturbing. Ok its small, and there'll be

It isnt viable to do driver work or small test critical work in 2.5 yet. The
same happened in 2.2/2.3 so I'm not too worried
