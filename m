Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262338AbTH0Vq0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 17:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbTH0Vq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 17:46:26 -0400
Received: from [62.241.33.80] ([62.241.33.80]:5894 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262338AbTH0VqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 17:46:24 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org,
       marcelo@conectiva.com.br, matthias.andree@gmx.de
Subject: Re: linux-2.4.22 released
Date: Wed, 27 Aug 2003 23:45:29 +0200
User-Agent: KMail/1.5.3
References: <200308251720.h7PHKDFi010397@harpo.it.uu.se>
In-Reply-To: <200308251720.h7PHKDFi010397@harpo.it.uu.se>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200308261901.21376.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 August 2003 19:20, Mikael Pettersson wrote:

Hi Marcelo, Mikale,

> > > Someone (sorry I forgot who) said they would submit a DRM update.
> > that one was me, but Alan and some others said, it needs a cleanup first.
> > I can provide an update from the latest -ac tree if it's ok and then we
> > can do the cleanup on this. Ok?
> Sounds good to me.

ack, to me too ;-)

I'll send this privately to all of you except lkml because it's somewhat huge.

Anyway, here some info about it:

Patch information:
------------------
- Update XFree DRM code to recent code from 2.4.22-rc2-ac3
- DRI now works with XFree v4.3.0
- ATI IGP chipset support added incl. pci ids, AGP support
- Initial VIA CLE266 and S3 Savage DRM modules merges from VIA
   (These are marked up with some warnings and need a chunk of clean up work)
- enabled 3dlabs GMX 2000 config option

All compiles cleanly, at least r128 (ati rage 128) works perfectly with XFree 
v4.3.0. I have such a card :)

ciao, Marc


