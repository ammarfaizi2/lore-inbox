Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291853AbSBNTn5>; Thu, 14 Feb 2002 14:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291851AbSBNTnr>; Thu, 14 Feb 2002 14:43:47 -0500
Received: from mark.staudinger.net ([207.252.75.224]:9735 "EHLO
	mark.staudinger.net") by vger.kernel.org with ESMTP
	id <S291846AbSBNTnj>; Thu, 14 Feb 2002 14:43:39 -0500
Message-Id: <200202141955.g1EJtwoX036235@mark.staudinger.net>
Date: Thu, 14 Feb 2002 19:55:58 -0000
To: "Drew P. Vogel" <dvogel@intercarve.net>
Subject: Re: 2.4.12 on Pentium?
From: "Mark Staudinger" <mark@staudinger.net>
X-Mailer: TWIG 2.6.2
In-Reply-To: <Pine.LNX.4.33.0202141233100.22263-100000@northface.intercarve.net>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: mark@staudinger.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Drew P. Vogel" <dvogel@intercarve.net> said:

> On Thu, 14 Feb 2002, Mark Staudinger wrote:
> 
> >
> >Is there any known problem with running kernel 2.4.12 on a P54/P55 CPU?  
I'm
> >unable to get a 2.4.12 kernel to boot on a pentium class machine, 
regardless
> >of what I choose for the "Processor Family" support in the config.
> >
> >A similar (if not identical) config of kernel 2.4.5 works just fine, even 
if
> >compiled for 686/Celeron processor family.
> 
> copy the .config from the 2.4.5 directory and do a 'make oldconfig' just
> to be sure.
> 
> --Drew Vogel

Done.  Still the same symptom (reset during kernel load). I take it this isn't 
a known problem then?

-=Mark


