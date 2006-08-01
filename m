Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751746AbWHASOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746AbWHASOw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 14:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751752AbWHASOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 14:14:52 -0400
Received: from blinkenlights.ch ([62.202.0.18]:14322 "EHLO blinkenlights.ch")
	by vger.kernel.org with ESMTP id S1751746AbWHASOv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 14:14:51 -0400
Date: Tue, 1 Aug 2006 20:14:49 +0200
From: Adrian Ulrich <reiser4@blinkenlights.ch>
To: David Masover <ninja@slaphack.com>
Cc: gmaxwell@gmail.com, alan@lxorguk.ukuu.org.uk, vonbrand@inf.utfsm.cl,
       bernd-schubert@gmx.de, reiserfs-list@namesys.com, jbglaw@lug-owl.de,
       clay.barnes@gmail.com, rudy@edsons.demon.nl, ipso@snappymail.ca,
       reiser@namesys.com, lkml@lpbproductions.com, jeff@garzik.org,
       tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
Message-Id: <20060801201449.cde3293c.reiser4@blinkenlights.ch>
In-Reply-To: <44CF9267.7050202@slaphack.com>
References: <200607312314.37863.bernd-schubert@gmx.de>
	<200608011428.k71ESIuv007094@laptop13.inf.utfsm.cl>
	<20060801165234.9448cb6f.reiser4@blinkenlights.ch>
	<1154446189.15540.43.camel@localhost.localdomain>
	<44CF84F0.8080303@slaphack.com>
	<e692861c0608011004x2ac1d9fcu353cd8e0d72eaac4@mail.gmail.com>
	<44CF9267.7050202@slaphack.com>
Organization: Bluewin AG
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.20; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > This is why ZFS offers block checksums... it can then try all the
> > permutations of raid regens to find a solution which gives the right
> > checksum.
> 
> Isn't there a way to do this at the block layer?  Something in 
> device-mapper?

Remember: Suns new Filesystem + Suns new Volume Manager = ZFS

