Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751711AbWBMKRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbWBMKRE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 05:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751713AbWBMKRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 05:17:04 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:399 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1751711AbWBMKRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 05:17:02 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 13 Feb 2006 11:14:35 +0100
To: schilling@fokus.fraunhofer.de, jengelh@linux01.gwdg.de
Cc: peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43F05C0B.nailKUS2493B9@burner>
References: <20060208165330.GB17534@voodoo>
 <43EB0DEB.nail52A1LVGUO@burner>
 <Pine.LNX.4.61.0602091729560.30108@yvahk01.tjqt.qr>
 <43EB7210.nailIDH2JUBZE@burner>
 <Pine.LNX.4.61.0602091813260.30108@yvahk01.tjqt.qr>
 <43EB7BBA.nailIFG412CGY@burner>
 <mj+md-20060209.173519.1949.atrey@ucw.cz>
 <43EC71FB.nailISD31LRCB@burner>
 <20060210114721.GB20093@merlin.emma.line.org>
 <43EC887B.nailISDGC9CP5@burner>
 <mj+md-20060210.123726.23341.atrey@ucw.cz>
 <43EC8E18.nailISDJTQDBG@burner>
 <Pine.LNX.4.61.0602101409320.31246@yvahk01.tjqt.qr>
 <43EC93A2.nailJEB1AMIE6@burner>
In-Reply-To: <43EC93A2.nailJEB1AMIE6@burner>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:

> Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
>
> > >> > Well, this is a deficit of the Linux kernel - not libscg.
> > >>
> > >> This is exactly what I have written -- extra effort is needed to get
> > >> a stable numbering (which Solaris does), but you can use a very similar
> > >> extra care to get stable names (which Linux with udev does).
> > >
> > >As this conceptional deficite in Linux causes Linux to break POSIX
> > >compliance e.g. for stat(2) with hot plugged devices, people with 
> >
> > The struct stat->st_rdev field need to be stable too to comply to POSIX?
>
> Correct.

Mmmm, it looks like I did oversee that you did change the subject.....

I did say that stat->st_dev needs to be stable

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
