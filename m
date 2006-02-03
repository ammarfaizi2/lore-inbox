Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbWBCQ6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbWBCQ6i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 11:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWBCQ6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 11:58:38 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:2005 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1751233AbWBCQ60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 11:58:26 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Fri, 03 Feb 2006 17:56:49 +0100
To: schilling@fokus.fraunhofer.de, psusi@cfl.rr.com
Cc: mrmacman_g4@mac.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net, jengelh@linux01.gwdg.de,
       James@superbug.co.uk, j@bitron.ch, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43E38B51.nail5CAZ1GYRE@burner>
References: <43DDFBFF.nail16Z3N3C0M@burner>
 <1138710764.17338.47.camel@juerg-t40p.bitron.ch>
 <43DF6812.nail3B44TLQOP@burner> <20060202062840.GI5501@mail>
 <43E1EA35.nail4R02QCGIW@burner> <20060202161853.GB8833@voodoo>
 <787b0d920602020917u1e7267c5lbea5f02182e0c952@mai <43E374CF.nail5CAMKAKEV@burner>
 <43E38084.9040200@cfl.rr.com>
In-Reply-To: <43E38084.9040200@cfl.rr.com>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Susi <psusi@cfl.rr.com> wrote:

> You CAN'T have multiple cdrecord processes burning the same disc at the 
> same time; the very idea makes no sense.  The O_EXCL just prevents you 
> from trying such foolishness and creating a coaster. 

It does not prevent you from creatig a coaster in case you connect e.g.
two ATAPI writers to the same ATA cable.


Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
