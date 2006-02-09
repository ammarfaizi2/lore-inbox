Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030424AbWBIK3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030424AbWBIK3Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 05:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030541AbWBIK3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 05:29:25 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:26840 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1030424AbWBIK3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 05:29:24 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Thu, 09 Feb 2006 11:27:30 +0100
To: schilling@fokus.fraunhofer.de, lkml@dervishd.net
Cc: peter.read@gmail.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43EB1912.nail7EL11L90P@burner>
References: <200602021717.08100.luke@dashjr.org>
 <Pine.LNX.4.61.0602031502000.7991@yvahk01.tjqt.qr>
 <200602031724.55729.luke@dashjr.org> <43E7545E.nail7GN11WAQ9@burner>
 <73d8d0290602060706o75f04c1cx@mail.gmail.com> <43E7680E.2000506@gmx.de>
 <20060206205437.GA12270@voodoo> <43E89B56.nailA792EWNLG@burner>
 <20060207183712.GC5341@voodoo> <43E9F1CD.nail2BR11FL52@burner>
 <20060208210219.GB9166@DervishD>
In-Reply-To: <20060208210219.GB9166@DervishD>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DervishD <lkml@dervishd.net> wrote:


> other half doesn't have it probably has a bad user interface. You
> know that if a program uses a naming convention different from ALL
> the rest of programs is because the program has a problem. You know
> that if the only UNIX program out there that doesn't use /dev entries
> to talk to devices is cdrecord, the problem *probably* is in
> cdrecord, and not in UNIX...

So why do you like to introduce a different naming scheme?

Look into the real world and you will find that most SCSI related programs
use a namischscheme that is either identical to what cdrecord does
or a very similar one.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
