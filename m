Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263865AbSJHVIP>; Tue, 8 Oct 2002 17:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263867AbSJHVIP>; Tue, 8 Oct 2002 17:08:15 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:22264 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S263865AbSJHVIN>; Tue, 8 Oct 2002 17:08:13 -0400
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <200210061527.g96FRp1I003853@pool-141-150-241-241.delv.east.verizon.net> 
References: <200210061527.g96FRp1I003853@pool-141-150-241-241.delv.east.verizon.net>  <20021005190638.GN585@phunnypharm.org> <3D9F3C5C.1050708@redhat.com> <20021005124321.D11375@work.bitmover.com> <3D9F49D9.304@redhat.com> <20021005162852.I11375@work.bitmover.com> <1033861827.4441.31.camel@irongate.swansea.linux.org.uk> <20021005165316.E12580@work.bitmover.com> <3D9FF435.1030604@pobox.com> <200210060846.g968klWf000632@pool-141-150-241-241.delv.east.verizon.net> <3D9FFD21.8040404@pobox.com> 
To: Skip Ford <skip.ford@verizon.net>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New BK License Problem? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 08 Oct 2002 22:13:48 +0100
Message-ID: <8973.1034111628@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


skip.ford@verizon.net said:
>  I sort of had vger in mind, but I could set up a crude read-only list
> of some sort if need be on my dynamic IP line.

If a list is set up on vger I'll feed the patches to it.

>  I can't seem to find dwmw2's script.. 

CVSROOT=:pserver:anoncvs@cvs.infradead.org:/home/cvs
grep -q $CVSROOT ~/.cvspass || ( echo "$CVSROOT Ay=0=h<Z" >> ~/.cvspass )
cvs -d $CVSROOT co bkexport

--
dwmw2


