Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269440AbUICAU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269440AbUICAU3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 20:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269436AbUICARI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 20:17:08 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:2958 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S269409AbUICAQC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 20:16:02 -0400
Date: Fri, 3 Sep 2004 01:14:09 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Spam <spam@tnonline.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jamie Lokier <jamie@shareable.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives (was: silent
 semantic changes with reiser4)
In-Reply-To: <32810200.20040903020308@tnonline.net>
Message-ID: <Pine.LNX.4.61.0409030112080.23011@fogarty.jakma.org>
References: <20040826150202.GE5733@mail.shareable.org>
 <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org>
 <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org>
 <1094118362.4847.23.camel@localhost.localdomain> <20040902161130.GA24932@mail.shareable.org>
 <Pine.LNX.4.61.0409030028510.23011@fogarty.jakma.org> <1835526621.20040903014915@tnonline.net>
 <1094165736.6170.19.camel@localhost.localdomain> <32810200.20040903020308@tnonline.net>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Sep 2004, Spam wrote:

>  Yes, some archive types can't be partially unzipped either. But my
>  point is that it wouldn't be transparent to the application/user in
>  the same way.

It doesnt matter whether it is transparent to the application. It can 
be the application which implements the required level of 
transparency.

User doesnt care what provides the transparency or how it's 
implemented.

>  ~S

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
A committee is a group that keeps the minutes and loses hours.
 		-- Milton Berle
