Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422653AbWBNQx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422653AbWBNQx0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 11:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422649AbWBNQx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 11:53:26 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:56235 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1422653AbWBNQxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 11:53:24 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Tue, 14 Feb 2006 17:47:55 +0100
To: trudheim@gmail.com, schilling@fokus.fraunhofer.de
Cc: Valdis.Kletnieks@vt.edu, peter.read@gmail.com, mj@ucw.cz,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net, jerome.lacoste@gmail.com,
       jengelh@linux01.gwdg.de, dhazelton@enter.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43F209BB.nailMWZP1XY5P@burner>
References: <20060208162828.GA17534@voodoo>
 <43F0A010.nailKUSR1CGG5@burner>
 <5a2cf1f60602130724n7b060e29r57411260b04d5972@mail.gmail.com>
 <43F0AA83.nailKUS171HI4B@burner>
 <5a2cf1f60602130805u537de206k22fa418ee214cf02@mail.gmail.com>
 <43F0B2BA.nailKUS1DNTEHA@burner>
 <Pine.LNX.4.61.0602131732190.24297@yvahk01.tjqt.qr>
 <43F0B5BE.nailMBX2SZNBE@burner>
 <200602131919.k1DJJF5G025923@turing-police.cc.vt.edu>
 <43F1C385.nailMWZ599SQ5@burner>
 <515e525f0602140501j1f9fbe14x8a3eef0bbf179035@mail.gmail.com>
In-Reply-To: <515e525f0602140501j1f9fbe14x8a3eef0bbf179035@mail.gmail.com>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anders Karlsson <trudheim@gmail.com> wrote:

> On 2/14/06, Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
> [snip]
> > -       How does HAL allow one cdrecord instance to work
> >         without being interrupted by HAL?
>
> Uuh, if the writer unit is plugged in via USB and HAL detects it going
> away, as in getting disconnected from the system, don't you think it
> would be a smart move for cdrecord to pay attention to such an alert?
>
> I am sure you can explain to me if there are overwhelming technical
> reason to continue dumping data to a non-existant device.

It seems that you did not loisten to this discussion before, why doyou come in 
now not knowing the topcis?

Try to get hand on the deleted bug entries on Debian and you will see how
cdrecord is interrupted.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
