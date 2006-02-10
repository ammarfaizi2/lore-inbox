Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbWBJMhb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWBJMhb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 07:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWBJMha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 07:37:30 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:16590 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1751245AbWBJMh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 07:37:28 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Fri, 10 Feb 2006 13:36:08 +0100
To: schilling@fokus.fraunhofer.de, lkml@dervishd.net
Cc: peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43EC88B8.nailISDH1Q8XR@burner>
References: <20060208162828.GA17534@voodoo>
 <43EA1D26.nail40E11SL53@burner> <20060208165330.GB17534@voodoo>
 <43EB0DEB.nail52A1LVGUO@burner>
 <Pine.LNX.4.61.0602091729560.30108@yvahk01.tjqt.qr>
 <43EB7210.nailIDH2JUBZE@burner>
 <Pine.LNX.4.61.0602091813260.30108@yvahk01.tjqt.qr>
 <43EB7BBA.nailIFG412CGY@burner>
 <mj+md-20060209.173519.1949.atrey@ucw.cz>
 <43EC71FB.nailISD31LRCB@burner> <20060210114930.GC2750@DervishD>
In-Reply-To: <20060210114930.GC2750@DervishD>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DervishD <lkml@dervishd.net> wrote:

>     My system is clueless, too! If I write a CD before plugging my
> USB storage device, my CD writer is on 0,0,0. If I plug my USB
> storage device *before* doing any access, my cdwriter is on 1,0,0.
> Pretty stable.

You are referring to a conceptional problem in the Linux kernel.
If you are unhappy with this, send a bug report to the related
people.

This does not belong to libscg.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
