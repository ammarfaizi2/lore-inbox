Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263342AbTAJHZu>; Fri, 10 Jan 2003 02:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263366AbTAJHYw>; Fri, 10 Jan 2003 02:24:52 -0500
Received: from dp.samba.org ([66.70.73.150]:5868 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S263544AbTAJHYo>;
	Fri, 10 Jan 2003 02:24:44 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Craig Wilkie <craig@homerjay.homelinux.org>
Subject: Re: [TRIVIAL] [PATCH 1 of 3] Fix errors making Docbook documentation 
In-reply-to: Your message of "06 Jan 2003 15:20:10 -0000."
             <1041866409.17472.25.camel@irongate.swansea.linux.org.uk> 
Date: Fri, 10 Jan 2003 11:50:00 +1100
Message-Id: <20030110073328.A11712C0DD@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1041866409.17472.25.camel@irongate.swansea.linux.org.uk> you write:
> On Mon, 2003-01-06 at 03:47, Rusty Trivial Russell wrote:
> > From:  Craig Wilkie <craig@homerjay.homelinux.org>
> >   Documentation/Docbook/kernel-api.tmpl - Remove references to source 
> >   files which do not contain kernel-doc comments, which caused "errors" in 
> >   the generated documentation.
> 
> Please don't do this. The proper fixes already exist just never got
> merged. Also documentation exists for those files and isnt merged. The
> docbook is not the problem, the pile of other missing bits is
> 
> Grab the docbook for those files from 2.4 and also the changes to the
> docbook generator

Too late, Linus took it.  Craig, since you're doing Documentation
patches, a forward port would be nice.

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
