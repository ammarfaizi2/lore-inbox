Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbUHGNO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbUHGNO4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 09:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbUHGNO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 09:14:56 -0400
Received: from mail.dif.dk ([193.138.115.101]:4844 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262006AbUHGNOz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 09:14:55 -0400
Date: Sat, 7 Aug 2004 14:54:10 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: mj@ucw.cz, James.Bottomley@steeleye.com, axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
In-Reply-To: <200408071128.i77BSNCd006957@burner.fokus.fraunhofer.de>
Message-ID: <Pine.LNX.4.61.0408071450590.2825@dragon.hygekrogen.localhost>
References: <200408071128.i77BSNCd006957@burner.fokus.fraunhofer.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Aug 2004, Joerg Schilling wrote:

> 
> >From: Martin Mares <mj@ucw.cz>
> 
> >> >Well, so could you please enlighten the Linux people and say in a couple
> >> >of words how it could be done?
> >> 
> >> 1)	Fetch the Solaris install CD images from:
> >> 	http://wwws.sun.com/software/solaris/solaris-express/get.html
> 
> >Grrr!  I wanted you to describe the solution, not how to install Solaris!
> 
> You wanted to get a description in 'a few words' - this cannot be done.
> 
> .... So I instucted you how to get the full desciption. 
> 
> You may of course look yourself for the documentation at docs.sun.com.......
> 
For those looking for a link to the man page in question  path_to_inst(4) 
: http://docs.sun.com/db/doc/816-5174/6mbb98uhn?q=path_to_inst&a=view


--
Jesper Juhl <juhl-lkml@dif.dk>
