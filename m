Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbTDXTKQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 15:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263427AbTDXTKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 15:10:16 -0400
Received: from alfie.demon.co.uk ([158.152.44.128]:13323 "EHLO
	bagpuss.pyrites.org.uk") by vger.kernel.org with ESMTP
	id S261710AbTDXTKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 15:10:16 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Nick.Holloway@pyrites.org.uk (Nick Holloway)
Newsgroups: list.linux-kernel
Subject: Re: Bad url in ioctl numbers [DVD decoder driver]
Date: 24 Apr 2003 20:22:22 +0100
Organization: Alfie's Internet Node
Message-ID: <b89dhe$i6g$1@alfie.demon.co.uk>
References: <20030423135250.GA332@elf.ucw.cz> <20030424052634.BE1272C11D@lists.samba.org>
X-Newsreader: NN version 6.5.0 CURRENT #120
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rusty@rustcorp.com.au (Rusty Russell) writes:
> In message <20030423135250.GA332@elf.ucw.cz> you write:
> > Hi!
> > 
> > This warns about bad url. I do not know what better to do with this.
> 
> If you don't have a better one, just leave it.  I don't think this
> patch helps.
> 
> >  0xA2    00-0F   DVD decoder driver      in development:
> > -                                        <http://linuxtv.org/dvd/api/>
> > +					URL no longer works: http://linuxtv.org/dvd/api/

A quick browse of linuxtv.org finds the following page:

	http://linuxtv.org/developer/dvdapi.html

I'll let someone else to cut a patch.

-- 
 `O O'  | Nick.Holloway@pyrites.org.uk
// ^ \\ | http://www.pyrites.org.uk/
