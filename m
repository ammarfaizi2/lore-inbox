Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267018AbRHJLjQ>; Fri, 10 Aug 2001 07:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267043AbRHJLjG>; Fri, 10 Aug 2001 07:39:06 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:1284 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S267018AbRHJLi7>; Fri, 10 Aug 2001 07:38:59 -0400
From: Andrzej Krzysztofowicz <kufel!ankry@green.mif.pg.gda.pl>
Message-Id: <200108100541.HAA00896@kufel.dom>
Subject: Re: Linux 2.4.7-ac10
To: kufel!mediaone.net!scott1021@green.mif.pg.gda.pl
Date: Fri, 10 Aug 2001 07:41:19 +0200 (CEST)
Cc: kufel!lxorguk.ukuu.org.uk!alan@green.mif.pg.gda.pl (Alan Cox),
        kufel!vger.kernel.org!linux-kernel@green.mif.pg.gda.pl
In-Reply-To: <Pine.LNX.4.33.0108091912210.8046-100000@tweety.localdomain> from "Scott M. Hoffman" at sie 09, 2001 07:14:31 
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Fri, 10 Aug 2001 at 00:35 +0100 Alan Cox wrote:
> 
> > > > o Merge DRM for XFree 4.1.x (XFree86 and others)
> > > Can I still use my RH7.1 box with X-4.0.3 and ATI DRI?
> >
> > The -ac tree lets you build either 4.0 or 4.1 DRM - its a config option -
> > pick 4.0
> > -
> 
>  I'm confused?  I'm unable to select the 4.1 option without first
> selecting the original DRM option.  Does selecting the 4.1 DRM turn off
> the 4.0 code?  Or is this why glxinfo segfaults for me now?

Try the patch I've just send with subject "[PATCH] double DRM - fixes"

Andrzej
