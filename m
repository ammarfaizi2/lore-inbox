Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbTKAO6l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 09:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263824AbTKAO6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 09:58:40 -0500
Received: from 194.149.109.108.adsl.nextra.cz ([194.149.109.108]:59529 "EHLO
	gate2.perex.cz") by vger.kernel.org with ESMTP id S262765AbTKAO6k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 09:58:40 -0500
Date: Sat, 1 Nov 2003 15:57:32 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Anthony DiSante <orders@nodivisions.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Audio skips when RAM is ~full
In-Reply-To: <3FA3AB99.1060408@nodivisions.com>
Message-ID: <Pine.LNX.4.53.0311011555090.29804@pnote.perex-int.cz>
References: <3FA34523.30902@nodivisions.com> <20031101062050.GA13731@alpha.home.local>
 <3FA353E4.60906@nodivisions.com> <20031101071907.GA6300@alpha.home.local>
 <3FA3AB99.1060408@nodivisions.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Nov 2003, Anthony DiSante wrote:

> Yeah... in my experience, the whole ac'97 deal is pretty buggy (for one
> thing, with both ALSA and OSS drivers, output is distorted unless I keep the
> volume below ~70%...).

It's ok. The AC97 codecs can apply gain (not only attenuation). Thus you
can overdrive your analog output and hear distortion. It's analog
behaviour not a bug.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs
