Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbWBMP6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWBMP6F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 10:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbWBMP6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 10:58:05 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:43992 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1750752AbWBMP5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 10:57:55 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 13 Feb 2006 16:56:18 +0100
To: schilling@fokus.fraunhofer.de, fmalita@gmail.com
Cc: tytso@mit.edu, peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de, diegocg@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43F0AC22.nailKUS1AW83M9@burner>
References: <mj+md-20060209.173519.1949.atrey@ucw.cz>
 <43EC71FB.nailISD31LRCB@burner>
 <20060210114721.GB20093@merlin.emma.line.org>
 <43EC887B.nailISDGC9CP5@burner>
 <mj+md-20060210.123726.23341.atrey@ucw.cz>
 <43EC8E18.nailISDJTQDBG@burner>
 <Pine.LNX.4.61.0602101409320.31246@yvahk01.tjqt.qr>
 <43EC93A2.nailJEB1AMIE6@burner> <20060210141651.GB18707@thunk.org>
 <43ECA3FC.nailJGC110XNX@burner> <20060210145238.GC18707@thunk.org>
 <43ECA934.nailJHD2NPUCH@burner>
 <20060210172428.6c857254.diegocg@gmail.com>
 <43F063A8.nailKUS7174MV@burner> <43F0A760.90405@gmail.com>
In-Reply-To: <43F0A760.90405@gmail.com>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florin Malita <fmalita@gmail.com> wrote:

> Joerg Schilling wrote:
>
> >>Could you explain why stat->st_dev / stat->st_ino POSIX semantics forces
> >>POSIX implementations to have a stable stat->st_rdev number? 
> >>    
> >>
> >
> >I was never talking about stat->st_rdev 
> >  
> >
> This is blatantly incorrect. You *were* talking about stat->st_rdev:
> http://lkml.org/lkml/2006/2/10/143
>
> On 2/10/06, *Joerg Schilling* <schilling@fokus.fraunhofer.de> wrote:
>
>     Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
>     > The struct stat->st_rdev field need to be stable too to comply to
>     POSIX?
>
>     Correct.
>
>     Jörg
>
>
> You may claim you *never meant to* or you *never realized* you were
> talking about, but you can't say you never talked about it - that's an
> outright lie.

You are lying here.

I did not write st_rdev and from my previous mail it was obvioys that 
I was referring to st_dev.



Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
