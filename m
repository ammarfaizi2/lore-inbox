Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261658AbVDEKOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbVDEKOp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 06:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVDEKMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 06:12:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52430 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261658AbVDEKGi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 06:06:38 -0400
Date: Tue, 5 Apr 2005 06:06:18 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Crash during boot for 2.6.12-rc2.
In-Reply-To: <20050404235130.27e3437a.akpm@osdl.org>
Message-ID: <Xine.LNX.4.44.0504050605170.10569-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Apr 2005, Andrew Morton wrote:

> James Morris <jmorris@redhat.com> wrote:
> >
> > n Mon, 4 Apr 2005, Andrew Morton wrote:
> > 
> >  > > I got this on a dual P4 Xeon with HT.  If anyone wants more information, 
> >  > >  let me know.
> >  > > 
> >  > 
> >  > .config, please..
> > 
> >  #
> >  # Automatically generated make config: don't edit
> >  # Linux kernel version: 2.6.12-rc2
> 
> Surprise, surprise, it works OK here.
> 
> What compiler version?

gcc -v
Using built-in specs.
Target: i386-redhat-linux
Configured with: ../configure --prefix=/usr --mandir=/usr/share/man 
--infodir=/usr/share/info --enable-shared --enable-threads=posix 
--enable-checking=release --with-system-zlib --enable-__cxa_atexit 
--disable-libunwind-exceptions --enable-languages=c,c++,objc,java,f95,ada 
--enable-java-awt=gtk --host=i386-redhat-linux
Thread model: posix
gcc version 4.0.0 20050329 (Red Hat 4.0.0-0.38)


I'll try a fresh compile later.

- James
-- 
James Morris 
<jmorris@redhat.com>


