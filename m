Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267320AbUHTNnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267320AbUHTNnI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 09:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267437AbUHTNnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 09:43:07 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:27088 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S267320AbUHTNmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 09:42:52 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Fri, 20 Aug 2004 15:41:54 +0200
To: schilling@fokus.fraunhofer.de, alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org, kernel@wildsau.enemy.org,
       fsteiner-mail@bio.ifi.lmu.de, diablod3@gmail.com,
       B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <4125FFA2.nail8LD61HFT4@burner>
References: <200408041233.i74CX93f009939@wildsau.enemy.org>
 <4124BA10.6060602@bio.ifi.lmu.de>
 <1092925942.28353.5.camel@localhost.localdomain>
 <200408191800.56581.bzolnier@elka.pw.edu.pl>
 <4124D042.nail85A1E3BQ6@burner>
 <1092938348.28370.19.camel@localhost.localdomain>
In-Reply-To: <1092938348.28370.19.camel@localhost.localdomain>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Iau, 2004-08-19 at 17:07, Joerg Schilling wrote:
> > Cdrtools is is code freeze state. This is why I say the best idea is to remove 
> > this interface change from the current Linux kernel and wait until there will
> > be new cdrtools alpha for 2.02 releases. These alpha could get support for uid
> > switching. If Linux then would again switch the changes on, it makes sense.
>
> While Sun did spend a year refusing to fix security holes I found -  for
> "compatibility reasons" - long ago back when I was a sysadmin at NTL,
> the Linux world does not work that way.

Unless you tell us what kind of "security holes" you found _and_ when this has 
been, it looks like a meaningless remark.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
