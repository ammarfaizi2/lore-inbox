Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932480AbWBIOzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbWBIOzR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 09:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbWBIOzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 09:55:17 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:4255 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S932480AbWBIOzQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 09:55:16 -0500
Date: Thu, 9 Feb 2006 15:55:42 +0100
From: DervishD <lkml@dervishd.net>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: peter.read@gmail.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060209145542.GA94@DervishD>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	peter.read@gmail.com, matthias.andree@gmx.de,
	linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net
References: <200602031724.55729.luke@dashjr.org> <43E7545E.nail7GN11WAQ9@burner> <73d8d0290602060706o75f04c1cx@mail.gmail.com> <43E7680E.2000506@gmx.de> <20060206205437.GA12270@voodoo> <43E89B56.nailA792EWNLG@burner> <20060207183712.GC5341@voodoo> <43E9F1CD.nail2BR11FL52@burner> <20060208210219.GB9166@DervishD> <43EB1912.nail7EL11L90P@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43EB1912.nail7EL11L90P@burner>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Joerg :)

 * Joerg Schilling <schilling@fokus.fraunhofer.de> dixit:
> DervishD <lkml@dervishd.net> wrote:
> > other half doesn't have it probably has a bad user interface. You
> > know that if a program uses a naming convention different from ALL
> > the rest of programs is because the program has a problem. You know
> > that if the only UNIX program out there that doesn't use /dev entries
> > to talk to devices is cdrecord, the problem *probably* is in
> > cdrecord, and not in UNIX...
> 
> So why do you like to introduce a different naming scheme?

    Exactly, Joerg, why do YOU like to introduce a different naming
scheme? UNIX uses /dev/whatever, Win32 uses <UNIT>:, etc. Why do you
want to break those names, which are familiar to the user?
 
> Look into the real world and you will find that most SCSI related
> programs use a namischscheme that is either identical to what
> cdrecord does or a very similar one.

    I don't know any program, except cdrecord and family, which uses
your naming scheme, but I will more than happy to hear examples, look
at them and change my mind if I finally get convinced that the naming
scheme you're using is finally better. But instead of telling me to
look into the real world, tell me examples, please. I don't have at
home any SCSI bus and so I don't use SCSI related programs.

    Thanks in advance :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to... RAmen!
