Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932437AbWBMPRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbWBMPRJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 10:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbWBMPRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 10:17:09 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:35499 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932437AbWBMPRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 10:17:08 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 13 Feb 2006 16:15:36 +0100
To: schilling@fokus.fraunhofer.de, matthias.andree@gmx.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43F0A298.nailKUSW190PU@burner>
References: <20060208162828.GA17534@voodoo>
 <200602090757.13767.dhazelton@enter.net>
 <43EC8F22.nailISDL17DJF@burner>
 <200602092221.56942.dhazelton@enter.net>
 <43F08C5F.nailKUSDKZUAZ@burner>
 <20060213135240.GD10566@merlin.emma.line.org>
In-Reply-To: <20060213135240.GD10566@merlin.emma.line.org>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@gmx.de> wrote:

> > For this reason, it is bejond the scope of the Linux kernel team to decide on 
> > this abstraction layer. The Linux kernel team just need to take the current
> > libscg interface as given as _this_  _is_ the way to do best abstraction.
>
> This is ridiculous. The abstraction (SG_IO on an open special file) is
> in the kernel. Feel free to stack as many layers on top as you wish, but
> the kernel isn't going to bend just to support a random abstraction
> library that cannot achieve its goals in its current form anyways.

Try to inform yourself on the difference between an IOCTL and a /dev/ entry.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
