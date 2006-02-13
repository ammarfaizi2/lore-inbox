Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750841AbWBMQ0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbWBMQ0V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 11:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbWBMQ0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 11:26:20 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:38387 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1750838AbWBMQ0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 11:26:20 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 13 Feb 2006 17:24:26 +0100
To: schilling@fokus.fraunhofer.de, jerome.lacoste@gmail.com
Cc: peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de, dhazelton@enter.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43F0B2BA.nailKUS1DNTEHA@burner>
References: <20060208162828.GA17534@voodoo>
 <43EC887B.nailISDGC9CP5@burner>
 <200602090757.13767.dhazelton@enter.net>
 <43EC8F22.nailISDL17DJF@burner>
 <5a2cf1f60602100738r465dd996m2ddc8ef18bf1b716@mail.gmail.com>
 <43F06220.nailKUS5D8SL2@burner>
 <5a2cf1f60602130407j79805b8al55fe999426d90b97@mail.gmail.com>
 <43F0A010.nailKUSR1CGG5@burner>
 <5a2cf1f60602130724n7b060e29r57411260b04d5972@mail.gmail.com>
 <43F0AA83.nailKUS171HI4B@burner>
 <5a2cf1f60602130805u537de206k22fa418ee214cf02@mail.gmail.com>
In-Reply-To: <5a2cf1f60602130805u537de206k22fa418ee214cf02@mail.gmail.com>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jerome lacoste <jerome.lacoste@gmail.com> wrote:

> The mapping I am talking about is currently done inside libscg (inside
> the scsi-*.c files). Hence libscg is the one capable of exposing this
> information to higher levels.
>
> > and how would you like to implement it OS independent?
>
> The information printed will be printed in a format such as:
>
> b,t,l <= os_specific_name

Why do you believe that this kind of mapping is needed?

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
