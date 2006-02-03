Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750860AbWBCKFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbWBCKFm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 05:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWBCKFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 05:05:42 -0500
Received: from mail.gmx.de ([213.165.64.21]:55263 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750860AbWBCKFl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 05:05:41 -0500
X-Authenticated: #428038
Date: Fri, 3 Feb 2006 11:05:36 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: xavier.bestel@free.fr, linux-kernel@vger.kernel.org, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060203100536.GA17144@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	xavier.bestel@free.fr, linux-kernel@vger.kernel.org,
	acahalan@gmail.com
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com> <43DF3C3A.nail2RF112LAB@burner> <5a2cf1f60601310424w6a64c865u590652fbda581b06@mail.gmail.com> <200601311333.36000.oliver@neukum.org> <1138867142.31458.3.camel@capoeira> <43E1EAD5.nail4R031RZ5A@burner> <1138880048.31458.31.camel@capoeira> <43E20047.nail4TP1PULVQ@burner> <1138885334.31458.42.camel@capoeira> <43E32884.nail5CA1O92YA@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E32884.nail5CA1O92YA@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-02-03:

> libscg & cdrecord have been available long before Linux HAL was there.

Perhaps libscg was too arcane and too badly integrated into Linux?

> And the most important argument here is that it is extremely unlikely that
> this Linux HAL will handle all oddities of all CD/DVD-writers, do it is 
> unapropriate to use this interface in case that you like to get more 
> information than just "the drive is there".
> 
> Note that UNIX people usually believe that is is best practice to have this 
> kind of software intergrated in the kernel (or at leat in the system). This is 
> what FreeBSD did try for some years, and FreeBSD has failed with this attempt.

So why would Linux want to have it in the kernel if it hasn't worked for
FreeBSD either? Thanks for proving it doesn't belong there BTW.

-- 
Matthias Andree
