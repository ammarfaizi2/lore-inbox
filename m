Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbUCIJiy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 04:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbUCIJiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 04:38:54 -0500
Received: from kempelen.iit.bme.hu ([152.66.241.120]:1693 "EHLO
	kempelen.iit.bme.hu") by vger.kernel.org with ESMTP id S261845AbUCIJiw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 04:38:52 -0500
Date: Tue, 9 Mar 2004 10:38:45 +0100 (MET)
Message-Id: <200403090938.i299cjv17207@kempelen.iit.bme.hu>
From: Miklos Szeredi <mszeredi@inf.bme.hu>
To: bernd.schubert@pci.uni-heidelberg.de,
       viro@parcelfarce.linux.theplanet.co.uk
CC: linux-kernel@vger.kernel.org
In-reply-to: <200403081710.00850.bernd.schubert@pci.uni-heidelberg.de>
	(message from Bernd Schubert on Mon, 8 Mar 2004 17:10:00 +0100)
Subject: Re: unionfs
References: <200403080952.i289qsU12658@kempelen.iit.bme.hu> <200403081710.00850.bernd.schubert@pci.uni-heidelberg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I have never tested it, but from other reports I read that it works.
> 
> http://translucency.sourceforge.net/

Thanks, but I'm not looking for a working unionfs, rather for design
ideas for doing these sort of 'layered' filesystems _properly_, not
with hacks like system call table modification (like the above
solution).

Al, can you please give some guidance?  Have you any code for a
unionfs design, or only ideas, or was this just myth?

Miklos
