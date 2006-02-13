Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbWBMRmd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWBMRmd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 12:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWBMRmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 12:42:33 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:60347 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932193AbWBMRmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 12:42:33 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 13 Feb 2006 18:40:51 +0100
To: schilling@fokus.fraunhofer.de, luke@dashjr.org
Cc: seanlkml@sympatico.ca, sam@vilain.net, peter.read@gmail.com, mj@ucw.cz,
       matthias.andree@gmx.de, lkml@dervishd.net, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net, jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43F0C4A3.nailMEM11MHR7@burner>
References: <43EB7BBA.nailIFG412CGY@burner>
 <mj+md-20060213.160108.13290.atrey@ucw.cz>
 <43F0B32D.nailKUS1E3S8I3@burner> <200602131722.29633.luke@dashjr.org>
In-Reply-To: <200602131722.29633.luke@dashjr.org>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luke-Jr <luke@dashjr.org> wrote:

> > I mentioned:
> >
> > -	ide-scsi does not do DMA correctly
>
> IIRC, ide-scsi is deprecated and would be removed as a fix for this bug. Note 
> that ide-scsi is known to be broken in more ways than just this-- for 
> example, unloading the module causes a kernel panic.

A last word on that:

-	this bug is known for more than 2 years.

-	time to fix: less than 3 hours for the right person

-	I therefore expect a fix in less than a month or
	I must asume that Linux is not longer actively maintained.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
