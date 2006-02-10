Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbWBJO4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbWBJO4F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 09:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWBJO4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 09:56:05 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:19377 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1751267AbWBJO4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 09:56:04 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Fri, 10 Feb 2006 15:54:44 +0100
To: tytso@mit.edu, schilling@fokus.fraunhofer.de
Cc: peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43ECA934.nailJHD2NPUCH@burner>
References: <mj+md-20060209.173519.1949.atrey@ucw.cz>
 <43EC71FB.nailISD31LRCB@burner>
 <20060210114721.GB20093@merlin.emma.line.org>
 <43EC887B.nailISDGC9CP5@burner>
 <mj+md-20060210.123726.23341.atrey@ucw.cz>
 <43EC8E18.nailISDJTQDBG@burner>
 <Pine.LNX.4.61.0602101409320.31246@yvahk01.tjqt.qr>
 <43EC93A2.nailJEB1AMIE6@burner> <20060210141651.GB18707@thunk.org>
 <43ECA3FC.nailJGC110XNX@burner> <20060210145238.GC18707@thunk.org>
In-Reply-To: <20060210145238.GC18707@thunk.org>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Theodore Ts'o" <tytso@mit.edu> wrote:

> On Fri, Feb 10, 2006 at 03:32:28PM +0100, Joerg Schilling wrote:
> > > Chapter and verse, please?  
> > >
> > > Can you please list the POSIX standard, section, and line number which
> > > states that a particular device must always have the same st_rdev
> > > across reboots, and hot plugs/unplugs?
> > 
> > A particular file on the system must not change st_dev while the system
> > is running.
> > 
> > http://www.opengroup.org/onlinepubs/009695399/basedefs/sys/stat.h.html
>
> 1)  File != device.

I am sorry, but it turns out that you did not understand the problem.

Try to inform yourself about the relevence (and content) of st_dev before
replying again.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
