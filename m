Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287531AbRLaOYe>; Mon, 31 Dec 2001 09:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287525AbRLaOYY>; Mon, 31 Dec 2001 09:24:24 -0500
Received: from inreach-gw1.idiom.com ([209.209.13.26]:43529 "EHLO
	smile.idiom.com") by vger.kernel.org with ESMTP id <S287519AbRLaOYS>;
	Mon, 31 Dec 2001 09:24:18 -0500
Message-ID: <3C307464.2253E26@obviously.com>
Date: Mon, 31 Dec 2001 09:21:24 -0500
From: Bryce Nesbitt <bryce@obviously.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
CC: Lionel Bouton <Lionel.Bouton@free.fr>, Andries.Brouwer@cwi.nl
Subject: Re: Why would a valid DVD show zero files on Linux?
In-Reply-To: <E16L2G8-00050T-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Does anyone want the first few K of this DVD to see why the autodetection
> > is not working better?  Do you want me to upgrade past Kernel 2.4.2-2 first?
> > Is RedHat 7.2's kernel good enough?
> 
> The autodetection is working. Your DVD has a UDF file system on it and a
> blank iso9660 one.

Understood.   However, why can't that combination "just work"?  Changing
/etc/fstab every time I switch between sticking in a CD-ROM and DVD-ROM is not cool.
Certainly that "other operating system" does not make me do that.

A disk with a blank iso9660 plus a full UDF ought to automatically mount UDF, no?
How hard would that be to detect?

		-Bryce


PS: I manually mount anyway, and only have two DVD-ROMs, so it's not such a
big deal for me.  But as DVD rom becomes more popular it could get inconvienent.
