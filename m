Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269489AbUICAvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269489AbUICAvu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 20:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269457AbUICAt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 20:49:57 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:50074 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S269473AbUICAjW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 20:39:22 -0400
Date: Fri, 3 Sep 2004 02:39:06 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <142794710.20040903023906@tnonline.net>
To: Paul Jakma <paul@clubi.ie>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jamie Lokier <jamie@shareable.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       <viro@parcelfarce.linux.theplanet.co.uk>,
       Christoph Hellwig <hch@lst.de>, <linux-fsdevel@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives (was: silent semantic changes with reiser4)
In-Reply-To: <Pine.LNX.4.61.0409030112080.23011@fogarty.jakma.org>
References: <20040826150202.GE5733@mail.shareable.org>
 <200408282314.i7SNErYv003270@localhost.localdomain>
 <20040901200806.GC31934@mail.shareable.org>
 <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org>
 <1094118362.4847.23.camel@localhost.localdomain>
 <20040902161130.GA24932@mail.shareable.org>
 <Pine.LNX.4.61.0409030028510.23011@fogarty.jakma.org>
 <1835526621.20040903014915@tnonline.net>
 <1094165736.6170.19.camel@localhost.localdomain>
 <32810200.20040903020308@tnonline.net>
 <Pine.LNX.4.61.0409030112080.23011@fogarty.jakma.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  

> On Fri, 3 Sep 2004, Spam wrote:

>>  Yes, some archive types can't be partially unzipped either. But my
>>  point is that it wouldn't be transparent to the application/user in
>>  the same way.

> It doesnt matter whether it is transparent to the application. It can
> be the application which implements the required level of 
> transparency.

> User doesnt care what provides the transparency or how it's 
> implemented.

  Indeed. I hope I didn't say otherwise :). Just that I think it will
  be very difficult to have this transparency in all apps. Just
  thinking of "nano file.jpg/description.txt" or "ls
  file.tar/untar/*.doc". Sure in some environments like Gnome it could
  work, but it still doesn't for the rest of the flora of Linux
  programs.



  ~S

> regards,

