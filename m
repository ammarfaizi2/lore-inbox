Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965068AbWBGNH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965068AbWBGNH7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 08:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbWBGNH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 08:07:59 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:64406 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S965068AbWBGNH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 08:07:58 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Tue, 07 Feb 2006 14:06:30 +0100
To: matthias.andree@gmx.de, jim@why.dont.jablowme.net
Cc: schilling@fokus.fraunhofer.de, peter.read@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43E89B56.nailA792EWNLG@burner>
References: <20060123105634.GA17439@merlin.emma.line.org>
 <200602021717.08100.luke@dashjr.org>
 <Pine.LNX.4.61.0602031502000.7991@yvahk01.tjqt.qr>
 <200602031724.55729.luke@dashjr.org> <43E7545E.nail7GN11WAQ9@burner>
 <73d8d0290602060706o75f04c1cx@mail.gmail.com> <43E7680E.2000506@gmx.de>
 <20060206205437.GA12270@voodoo>
In-Reply-To: <20060206205437.GA12270@voodoo>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jim Crilly" <jim@why.dont.jablowme.net> wrote:

> You're not alone, I'm still waiting for an answer as to why cdrecord is
> the only userland app on any OS to use his SCSI ID naming convention
> and yet his is the correct way. I've asked twice and been blatantly
> ignored both times.

Well, while I did explain this many times (*), I am still waiting 
for an explanation why Linux tries to deviate from nearly all other OS.

*) in case you like are on amnesia: without the mapping in libscg,
cdrecord could not be used reliably on Linux. And yes, I _do_ care
about people who run Linux-2.4 or older!


It seems that we should stop this discussion.

As long as the peeople who answer here are onlookers without the 
needed skills, it seems to be a waste of time.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
