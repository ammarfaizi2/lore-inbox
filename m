Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751346AbWBJK7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbWBJK7n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 05:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbWBJK7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 05:59:42 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:40952 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1751346AbWBJK7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 05:59:42 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Fri, 10 Feb 2006 11:58:28 +0100
To: schilling@fokus.fraunhofer.de, matthias.andree@gmx.de
Cc: peter.read@gmail.com, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net, jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43EC71D4.nailISD2M37NB@burner>
References: <200602031724.55729.luke@dashjr.org>
 <43E7545E.nail7GN11WAQ9@burner>
 <73d8d0290602060706o75f04c1cx@mail.gmail.com> <43E7680E.2000506@gmx.de>
 <20060206205437.GA12270@voodoo> <43E89B56.nailA792EWNLG@burner>
 <20060207183712.GC5341@voodoo> <43E9F1CD.nail2BR11FL52@burner>
 <20060208162828.GA17534@voodoo> <43EA1D26.nail40E11SL53@burner>
 <20060208165330.GB17534@voodoo> <43EB0DEB.nail52A1LVGUO@burner>
 <Pine.LNX.4.61.0602091729560.30108@yvahk01.tjqt.qr>
 <43EB7210.nailIDH2JUBZE@burner>
 <Pine.LNX.4.61.0602091813260.30108@yvahk01.tjqt.qr>
 <43EB7BBA.nailIFG412CGY@burner> <43EB7D8A.1030906@gmx.de>
In-Reply-To: <43EB7D8A.1030906@gmx.de>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@gmx.de> wrote:

> > This is why the mapping engine is in the Linux adoption part of
> > libscg. It maps the non-stable device <-> /dev/sg* relation to a
> > stable b,t,l address.
>
> Well, the b,t,l mapping, judging from libscg code, is as stable as the
> ordering of the device nodes themselves, so it is not clear what the
> advantage would be other than getting a uniform and artificial b,t,l mapping.

It would help a lot if you at least _try_ to inform yourself before posting.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
