Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284017AbRLWHUq>; Sun, 23 Dec 2001 02:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284264AbRLWHUe>; Sun, 23 Dec 2001 02:20:34 -0500
Received: from fmfdns01.fm.intel.com ([132.233.247.10]:24535 "EHLO
	calliope1.fm.intel.com") by vger.kernel.org with ESMTP
	id <S284017AbRLWHUZ>; Sun, 23 Dec 2001 02:20:25 -0500
Message-ID: <59885C5E3098D511AD690002A5072D3C42D81C@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'ebiederm@xmission.com'" <ebiederm@xmission.com>, dcinege@psychosis.com
Cc: otto.wyss@bluewin.ch,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: RE: Booting a modular kernel through a multiple streams file
Date: Sat, 22 Dec 2001 23:20:18 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: ebiederm@xmission.com [mailto:ebiederm@xmission.com]
> > Basically what Grub does is loads the kernel modules from disk
> > into memory, and 'tells' the kernel the memory location to load
> > them from, very similar to how an initrd file is loaded. The problem
> > is Linux, is not MBS compilant and doesn't know to look for and load
> > the modules. 
> 
> So tell me how you make an MBS compliant alpha kernel again?

1) Someone writes a MBS spec chapter for Alpha
2) Someone implements it.

Any volunteers? (Eric? ;-))

It's all about scratching an itch, right? Things don't become cross-platform
by themselves. Linux started out 386-only, after all.

Regards -- Andy
