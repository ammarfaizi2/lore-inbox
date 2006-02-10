Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbWBJMg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbWBJMg6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 07:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWBJMg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 07:36:58 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:61901 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1751246AbWBJMg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 07:36:57 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Fri, 10 Feb 2006 13:35:07 +0100
To: schilling@fokus.fraunhofer.de, matthias.andree@gmx.de
Cc: peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43EC887B.nailISDGC9CP5@burner>
References: <20060208162828.GA17534@voodoo>
 <43EA1D26.nail40E11SL53@burner> <20060208165330.GB17534@voodoo>
 <43EB0DEB.nail52A1LVGUO@burner>
 <Pine.LNX.4.61.0602091729560.30108@yvahk01.tjqt.qr>
 <43EB7210.nailIDH2JUBZE@burner>
 <Pine.LNX.4.61.0602091813260.30108@yvahk01.tjqt.qr>
 <43EB7BBA.nailIFG412CGY@burner>
 <mj+md-20060209.173519.1949.atrey@ucw.cz>
 <43EC71FB.nailISD31LRCB@burner>
 <20060210114721.GB20093@merlin.emma.line.org>
In-Reply-To: <20060210114721.GB20093@merlin.emma.line.org>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@gmx.de> wrote:

> > > Nonsense. The b,t,l addresses are NOT stable (at least for transports
> > 
> > Dou you like to verify that you have no clue on SCSI?
>
> How does, for instance, libscg make sure that the b,t,l mappings are
> hotplug invariant?
>
> How does libscg make sure that two external writers, say USB, retain
> their b,t,l mappings if both are unplugged and then replugged in reverse
> order, perhaps into different USB hubs?

Well, this is a deficit of the Linux kernel - not libscg.

If you are unhappy with Hot plug support on Linux, I recommend you to
check Solaris.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
