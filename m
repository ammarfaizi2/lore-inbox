Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbWBJLAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWBJLAk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 06:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWBJLAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 06:00:40 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:62714 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1751348AbWBJLAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 06:00:39 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Fri, 10 Feb 2006 11:59:07 +0100
To: schilling@fokus.fraunhofer.de, mj@ucw.cz
Cc: peter.read@gmail.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net, jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43EC71FB.nailISD31LRCB@burner>
References: <20060207183712.GC5341@voodoo>
 <43E9F1CD.nail2BR11FL52@burner> <20060208162828.GA17534@voodoo>
 <43EA1D26.nail40E11SL53@burner> <20060208165330.GB17534@voodoo>
 <43EB0DEB.nail52A1LVGUO@burner>
 <Pine.LNX.4.61.0602091729560.30108@yvahk01.tjqt.qr>
 <43EB7210.nailIDH2JUBZE@burner>
 <Pine.LNX.4.61.0602091813260.30108@yvahk01.tjqt.qr>
 <43EB7BBA.nailIFG412CGY@burner>
 <mj+md-20060209.173519.1949.atrey@ucw.cz>
In-Reply-To: <mj+md-20060209.173519.1949.atrey@ucw.cz>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Mares <mj@ucw.cz> wrote:

> Hello!
>
> > This is why the mapping engine is in the Linux adoption part of
> > libscg. It maps the non-stable device <-> /dev/sg* relation to a
> > stable b,t,l address.
>
> Nonsense. The b,t,l addresses are NOT stable (at least for transports

Dou you like to verify that you have no clue on SCSI?



Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
