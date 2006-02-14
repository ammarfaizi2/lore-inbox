Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161064AbWBNPGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161064AbWBNPGm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 10:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161065AbWBNPGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 10:06:41 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:15554 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1161064AbWBNPGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 10:06:41 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Tue, 14 Feb 2006 16:04:54 +0100
To: jengelh@linux01.gwdg.de, dhazelton@enter.net
Cc: seanlkml@sympatico.ca, schilling@fokus.fraunhofer.de, sam@vilain.net,
       peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       lkml@dervishd.net, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43F1F196.nailMWZE1HZK5@burner>
References: <43EB7BBA.nailIFG412CGY@burner>
 <mj+md-20060213.160108.13290.atrey@ucw.cz>
 <43F0B32D.nailKUS1E3S8I3@burner>
 <200602131842.02377.dhazelton@enter.net>
 <Pine.LNX.4.61.0602140903400.7198@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0602140903400.7198@yvahk01.tjqt.qr>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

> >
> >> -	SCSI commands are bastardized on ATAPI
> >
> >identify the problem - provide a test case or two and I'll get off my lazy ass 
> >and see if I can't figure out what's causing the problem.
> >
>
> Maybe we can put a testsuite together that sends all sorts of commands to a 
> cd drive and then see with 1. which Linuxes 2. which models it happens.

You need to ask around for people with problems....
Debian had some relevent data but removed it the day I was referring to it :-(

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
