Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316842AbSGLT44>; Fri, 12 Jul 2002 15:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317788AbSGLT4z>; Fri, 12 Jul 2002 15:56:55 -0400
Received: from pD9E235D3.dip.t-dialin.net ([217.226.53.211]:20870 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316842AbSGLT4n>; Fri, 12 Jul 2002 15:56:43 -0400
Date: Fri, 12 Jul 2002 13:58:29 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Joerg Schilling <schilling@fokus.gmd.de>
cc: alan@lxorguk.ukuu.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE/ATAPI in 2.5
In-Reply-To: <200207121949.g6CJnNOj018428@burner.fokus.gmd.de>
Message-ID: <Pine.LNX.4.44.0207121356130.3421-100000@hawkeye.luckynet.adm>
X-Location: Potsdam; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 12 Jul 2002, Joerg Schilling wrote:
> >> Describe the problems.
> 
> >Go read the source code, do your own homework
> 
> Fine! You repeat that you have no argument that stands a check.

No, he just told you to do the checking on your own.

> So let us take it as prooven that there is no problem with resent
> (< 10 year old) drives. 

I got a drive at home which is from 1996 and doesn't do ATAPI. It's some 
Mitsumi indestructible, but I can't tell you details since I won't be at 
home within the next few weeks.

> >It has a huge amount to do with dev_t. It should be immediately obvious
> >why dev_t is a critical factor in getting that interface working in a
> >sane fashion.
> 
> If a sane driver interface depends on dev_t being 32 bits, then there
> would be a lot og junk in the Linux kernel :-(

Say the same about any kind of vars, and watch us laugh...

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

