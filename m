Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264883AbTAJLHG>; Fri, 10 Jan 2003 06:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264908AbTAJLHG>; Fri, 10 Jan 2003 06:07:06 -0500
Received: from hauptpostamt.charite.de ([193.175.66.220]:40679 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id <S264883AbTAJLHF>; Fri, 10 Jan 2003 06:07:05 -0500
Date: Fri, 10 Jan 2003 12:15:47 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21pre3-ac2
Message-ID: <20030110111547.GB18007@charite.de>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200301090139.h091d9G26412@devserv.devel.redhat.com> <20030110094504.GM25979@charite.de> <1042200029.28469.55.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042200029.28469.55.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox <alan@lxorguk.ukuu.org.uk>:
> On Fri, 2003-01-10 at 09:45, Ralf Hildebrandt wrote:
> > I got an oops with that kernel on two different machines:
> 
> Can you build the kernel with the patch to mm/shmem.c reverted and
> see if that fixes your crash ?

Well, yes. Should I remove all changes to "mm/shmem.c" that are done
from the ac2 patch?

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite Campus Mitte                            Tel.  +49 (0)30-450 570-155
Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-916
Why you can't find your system administrators:
On the roof of the building, contemplating which users to throw off. 

