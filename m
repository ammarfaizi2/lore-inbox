Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161051AbWBNNiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161051AbWBNNiv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 08:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161053AbWBNNiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 08:38:51 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:16364 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1161051AbWBNNiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 08:38:50 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Tue, 14 Feb 2006 14:37:14 +0100
To: schilling@fokus.fraunhofer.de, dhazelton@enter.net
Cc: peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jerome.lacoste@gmail.com, jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43F1DD0A.nailMWZ718HUV@burner>
References: <20060208162828.GA17534@voodoo>
 <200602092241.29294.dhazelton@enter.net>
 <43F08D45.nailKUSE1SA4H@burner>
 <200602131801.47050.dhazelton@enter.net>
In-Reply-To: <200602131801.47050.dhazelton@enter.net>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"D. Hazelton" <dhazelton@enter.net> wrote:

> > -	does not need more time to integrate than I would need to
> > 	write this from scratch
> >
> > Unfortunately, many people who send patches to me do not follow
> > these simple rules.
>
> Okay - show me your standards document and I'll get to work on a patch to do 
> what I earlier proposed. It won't be "adding new functionality" but it will 
> be making the interface a tiny bit simpler for the novice user.

?????

1)	RTFM
2)	ftp://ftp.berlios.de/pub/cdrecord/PORTING
3)	http://cdrecord.berlios.de/old/private/port.ps
4)	http://cvs.opensolaris.org/source/xref/on/usr/src/tools/scripts/cstyle.pl


If you do not follow the spirit of the interface design or of you break
things on other OS, your patch will not be accepted.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
