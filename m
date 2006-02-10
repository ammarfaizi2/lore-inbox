Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbWBJM0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWBJM0l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 07:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbWBJM0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 07:26:41 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:18629 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1751208AbWBJM0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 07:26:40 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Fri, 10 Feb 2006 13:24:40 +0100
To: mrmacman_g4@mac.com, jim@why.dont.jablowme.net
Cc: schilling@fokus.fraunhofer.de, peter.read@gmail.com, mj@ucw.cz,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43EC8608.nailISDBRK3MA@burner>
References: <20060206205437.GA12270@voodoo>
 <43E89B56.nailA792EWNLG@burner> <20060207183712.GC5341@voodoo>
 <43E9F1CD.nail2BR11FL52@burner> <20060208162828.GA17534@voodoo>
 <43EA1D26.nail40E11SL53@burner> <20060208165330.GB17534@voodoo>
 <43EB0DEB.nail52A1LVGUO@burner>
 <mj+md-20060209.095744.7127.atrey@ucw.cz>
 <233CD3FF-0017-4A74-BE6A-0487DF3F4EA8@mac.com>
 <20060210015201.GP18918@voodoo>
In-Reply-To: <20060210015201.GP18918@voodoo>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jim Crilly" <jim@why.dont.jablowme.net> wrote:

> On 02/09/06 06:14:40PM -0500, Kyle Moffett wrote:
> > Does cdrecord talk to CPU devices? No! Why do you care?  BTW: What  
> > the hell is a "CPU device" and why the hell would you think you could  
> > talk to it through a disk interface, let alone some other random SCSI  
> > interface?
> > 
>
> We have several fiber controllers and the controller itself does show up as
> a SCSI device that sg can bind to, I believe the management software can
> actually manage the storage via that node but we've never used it and I
> highly doubt anyone uses cdrecord or libscg for that purpose.

In fact, a "CPU device" (*) was it, that did give the initial push for my SCSI
activities in January 1985 and that did lead to the first SCSI genric driver
/dev/scg and libscg in August 1986.



*) Really a scanner but Scanner devices had not been defined by the SCSI
stabdard in 1985.


Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
