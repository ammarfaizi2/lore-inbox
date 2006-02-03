Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbWBCN5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWBCN5v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 08:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWBCN5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 08:57:50 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:25797 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750802AbWBCN5u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 08:57:50 -0500
Date: Fri, 3 Feb 2006 14:57:42 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Matthias Andree <matthias.andree@gmx.de>
cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, xavier.bestel@free.fr,
       linux-kernel@vger.kernel.org, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <20060203100536.GA17144@merlin.emma.line.org>
Message-ID: <Pine.LNX.4.61.0602031456360.7991@yvahk01.tjqt.qr>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
 <43DF3C3A.nail2RF112LAB@burner> <5a2cf1f60601310424w6a64c865u590652fbda581b06@mail.gmail.com>
 <200601311333.36000.oliver@neukum.org> <1138867142.31458.3.camel@capoeira>
 <43E1EAD5.nail4R031RZ5A@burner> <1138880048.31458.31.camel@capoeira>
 <43E20047.nail4TP1PULVQ@burner> <1138885334.31458.42.camel@capoeira>
 <43E32884.nail5CA1O92YA@burner> <20060203100536.GA17144@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 
>> Note that UNIX people usually believe that is is best practice to have this 
>> kind of software intergrated in the kernel (or at leat in the system). This is 
>> what FreeBSD did try for some years, and FreeBSD has failed with this attempt.
>
>So why would Linux want to have it in the kernel if it hasn't worked for
>FreeBSD either? Thanks for proving it doesn't belong there BTW.
>
There's also something in the FreeBSD kernel that does work there, but has 
not worked out as good for Linux ;-) [devfs]

Therefore I would not generalize it and say "if it did not work on <x>, we 
don't need to implement it for our <y>".


Jan Engelhardt
-- 
