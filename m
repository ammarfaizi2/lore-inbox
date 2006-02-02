Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751039AbWBBMwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbWBBMwq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 07:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbWBBMwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 07:52:46 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:46271 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1751037AbWBBMwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 07:52:46 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Thu, 02 Feb 2006 13:51:19 +0100
To: xavier.bestel@free.fr, schilling@fokus.fraunhofer.de
Cc: oliver@neukum.org, mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jerome.lacoste@gmail.com,
       jengelh@linux01.gwdg.de, James@superbug.co.uk, j@bitron.ch,
       acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43E20047.nail4TP1PULVQ@burner>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
 <43DF3C3A.nail2RF112LAB@burner>
 <5a2cf1f60601310424w6a64c865u590652fbda581b06@mail.gmail.com>
 <200601311333.36000.oliver@neukum.org>
 <1138867142.31458.3.camel@capoeira> <43E1EAD5.nail4R031RZ5A@burner>
 <1138880048.31458.31.camel@capoeira>
In-Reply-To: <1138880048.31458.31.camel@capoeira>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xavier Bestel <xavier.bestel@free.fr> wrote:

> > > As repeated over and over here, there is such a way, it's called HAL and
> > > it is cross-platform. And it's what's used by some GUIs out there (e.g.
> > > nautilus-cd-burner).
> > 
> > The fact that people here repeat unadquate proposals forces me to repeat my 
> > proposals. Name a list fo OS that implement HAL and then look at the list
> > of crecord supported platforms 
>
> Well ... from your sayings it seems Linux is supported by HAL but not by
> libscg. 

Libscg is _the_ HAL for cdrecord. It is availaible the same way as today since
10 years.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
