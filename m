Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265107AbSKERv7>; Tue, 5 Nov 2002 12:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265108AbSKERv7>; Tue, 5 Nov 2002 12:51:59 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:38037 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265107AbSKERv4>; Tue, 5 Nov 2002 12:51:56 -0500
Subject: Re: 2.5 vi .config ; make oldconfig not working
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Arjan van de Ven <arjanv@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021105172617.GC1830@suse.de>
References: <20021105165024.GJ13587@suse.de> <3DC7FB11.10209@pobox.com>
	<20021105171409.GA1137@suse.de>
	<1036517201.5601.0.camel@localhost.localdomain> 
	<20021105172617.GC1830@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Nov 2002 18:20:35 +0000
Message-Id: <1036520436.4791.114.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-05 at 17:26, Jens Axboe wrote:
> You're wrong, it's always worked. I've never used anything but that.
> 
> > # CONFIG_NFSD_V4 is not set
> 
> Come on, you really expect me to type the whole damn thing? That's
> silly.

So write a sed script to turn n into "is not set" or submit a change to
cover it. Its luck =n ever did what you expected though.

