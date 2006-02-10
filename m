Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbWBJNFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWBJNFa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 08:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbWBJNF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 08:05:29 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:27110 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932070AbWBJNF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 08:05:27 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Fri, 10 Feb 2006 14:03:30 +0100
To: schilling@fokus.fraunhofer.de, dhazelton@enter.net
Cc: peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43EC8F22.nailISDL17DJF@burner>
References: <20060208162828.GA17534@voodoo>
 <20060210114721.GB20093@merlin.emma.line.org>
 <43EC887B.nailISDGC9CP5@burner>
 <200602090757.13767.dhazelton@enter.net>
In-Reply-To: <200602090757.13767.dhazelton@enter.net>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"D. Hazelton" <dhazelton@enter.net> wrote:

> And does cdrecord even need libscg anymore? From having actually gone through 
> your code, Joerg, I can tell you that it does serve a larger purpose. But at 
> this point I have to ask - besides cdrecord and a few other _COMPACT_ _DISC_ 
> writing programs, does _ANYONE_ use libscg? Is it ever used to access any 
> other devices that are either SCSI or use a SCSI command protocol (like 
> ATAPI)?  My point there is that you have a wonderful library, but despite 
> your wishes, there is no proof that it is ever used for anything except 
> writing/ripping CD's.

Name a single program (not using libscg) that implements user space SCSI and runs 
on as many platforms as cdrecord/libscg does.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
