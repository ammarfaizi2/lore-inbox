Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266929AbUBGPKI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 10:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266931AbUBGPKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 10:10:08 -0500
Received: from fep03.swip.net ([130.244.199.131]:46332 "EHLO
	fep03-svc.swip.net") by vger.kernel.org with ESMTP id S266929AbUBGPKC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 10:10:02 -0500
From: jjluza <jjluza@free.fr>
Reply-To: jjluza@free.fr
To: Jaroslav Kysela <perex@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: BUG: 2.6.3-rc1: No sound with nforce2 sound system
Date: Sat, 7 Feb 2004 16:10:04 +0100
User-Agent: KMail/1.6
References: <200402071357.35566.jjluza@free.fr> <Pine.LNX.4.58.0402071602580.2460@pnote.perex-int.cz>
In-Reply-To: <Pine.LNX.4.58.0402071602580.2460@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200402071610.04856.jjluza@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Saturday 07 February 2004 16:06, vous avez écrit :
> We know about this bug. It's related to VRA detection which is failing for
> multichannel codecs in some cases. You may try to force your game to
> 48000Hz/16-bit/stereo audio parameters until we can fix this bug - or look
> to Documentation/sound/alsa/OSS-Emulation.txt for hints to make quake
> working. Unfortunately no primary ALSA developer has access to this
> type of hardware so debugging is quite slow using e-mails.
>
> 						Jaroslav
>
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SuSE Labs

ok, in fact I thought that it's strange because I've never get this type of 
problem before
I'll try what you said and hope that it will work
thanks

PS: maybe I can help to debug the problem with devel by mail ? do you know who 
I should contact to help ?
