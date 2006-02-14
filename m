Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161019AbWBNLtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161019AbWBNLtx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 06:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161021AbWBNLtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 06:49:53 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:33767 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1161019AbWBNLtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 06:49:52 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Tue, 14 Feb 2006 12:48:21 +0100
To: Valdis.Kletnieks@vt.edu, schilling@fokus.fraunhofer.de
Cc: peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jerome.lacoste@gmail.com, jengelh@linux01.gwdg.de, dhazelton@enter.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43F1C385.nailMWZ599SQ5@burner>
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
 <43F0B2BA.nailKUS1DNTEHA@burner>
 <Pine.LNX.4.61.0602131732190.24297@yvahk01.tjqt.qr>
 <43F0B5BE.nailMBX2SZNBE@burner>
 <200602131919.k1DJJF5G025923@turing-police.cc.vt.edu>
In-Reply-To: <200602131919.k1DJJF5G025923@turing-police.cc.vt.edu>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:

> On Mon, 13 Feb 2006 17:37:18 +0100, Joerg Schilling said:
>
> > And if you have a working vold on Solaris, libscg accepts the vold aliases.
>
> And if you have a working hald on Linux, libscg should therefor accept hald aliases.

How about pointing to _useful_ documentation:

-	How to find _any_ device that talks SCSI?

-	How does HAL allow one cdrecord instance to work
	without being interrupted by HAL?

-	How to send non disturbing SCSI commands from another
	cdrecord process in case one or more are already running?

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
