Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267450AbRG2L6o>; Sun, 29 Jul 2001 07:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267958AbRG2L6e>; Sun, 29 Jul 2001 07:58:34 -0400
Received: from gip.u-picardie.fr ([193.49.184.17]:25897 "EHLO
	gip.u-picardie.fr") by vger.kernel.org with ESMTP
	id <S267450AbRG2L6Z>; Sun, 29 Jul 2001 07:58:25 -0400
Date: Sun, 29 Jul 2001 13:58:07 +0200
From: Jean Charles Delepine <delepine@u-picardie.fr>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, debian-devel@lists.debian.org,
        Herbert Xu <herbert@debian.org>,
        Manoj Srivastava <srivasta@debian.org>
Subject: Re: make rpm
Message-ID: <20010729135807.J8982@u-picardie.fr>
In-Reply-To: <E15QeJf-0008O8-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15QeJf-0008O8-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Jul 29, 2001 at 01:20:19AM +0100
X-Organization: Jack Daniel - Canal Habituel
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Alan Cox <alan@lxorguk.ukuu.org.uk> écrivait (wrote) :

> I've been meaning to do this one for a while and I now have it working so
> that with my current -ac kernel working tree I can type
> 
> 	make rpm
> 
> and out puts kernel-2.4.7ac3-1.i386.rpm
> 
> All this took was the pieces below.
> 
> Anyone care to knock up a "make dpkg" to go with it ?

Maybe Herbert Xu, the actual developper of the Debian kernel package or 
Manoj Srivastava, for the Debian Linux kernel package build scripts can
do that.

debian-devel, Herbert and Manoj are Cc-ed.

For those cc-ed who don't read linux-kernel, the entire thread can be read on
http://groups.google.com/groups?hl=en&safe=off&th=228bf616886d8b69,5&seekm=linux.kernel.E15Qeav-0008P4-00%40the-village.bc.nu#p

              Jean Charles
-- 
Jean Charles Delépine - Équipe Réseaux Télécoms - Université de Picardie
