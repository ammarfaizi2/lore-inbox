Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266962AbUBGPS0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 10:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266961AbUBGPRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 10:17:41 -0500
Received: from 194.149.109.108.adsl.nextra.cz ([194.149.109.108]:16079 "EHLO
	gate2.perex.cz") by vger.kernel.org with ESMTP id S266958AbUBGPRj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 10:17:39 -0500
Date: Sat, 7 Feb 2004 17:17:27 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: jjluza <jjluza@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: 2.6.3-rc1: No sound with nforce2 sound system
In-Reply-To: <200402071610.04856.jjluza@free.fr>
Message-ID: <Pine.LNX.4.58.0402071716200.2460@pnote.perex-int.cz>
References: <200402071357.35566.jjluza@free.fr> <Pine.LNX.4.58.0402071602580.2460@pnote.perex-int.cz>
 <200402071610.04856.jjluza@free.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Feb 2004, jjluza wrote:

> Le Saturday 07 February 2004 16:06, vous avez écrit :
> > We know about this bug. It's related to VRA detection which is failing for
> > multichannel codecs in some cases. You may try to force your game to
> > 48000Hz/16-bit/stereo audio parameters until we can fix this bug - or look
> > to Documentation/sound/alsa/OSS-Emulation.txt for hints to make quake
> > working. Unfortunately no primary ALSA developer has access to this
> > type of hardware so debugging is quite slow using e-mails.
> 
> ok, in fact I thought that it's strange because I've never get this type of 
> problem before
> I'll try what you said and hope that it will work
> thanks
> 
> PS: maybe I can help to debug the problem with devel by mail ? do you know who 
> I should contact to help ?

See http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/
'intel8x0 has stopped working' thread (last e-mails).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs
