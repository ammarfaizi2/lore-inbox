Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262402AbUBXTBR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 14:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbUBXTBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 14:01:17 -0500
Received: from 194.149.109.108.adsl.nextra.cz ([194.149.109.108]:13455 "EHLO
	gate2.perex.cz") by vger.kernel.org with ESMTP id S262402AbUBXTBP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 14:01:15 -0500
Date: Tue, 24 Feb 2004 19:56:42 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Plaz McMan <plazmcman@softhome.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OSS API emulation in 2.6.3
In-Reply-To: <403B9AD0.2050006@softhome.net>
Message-ID: <Pine.LNX.4.58.0402241956270.1883@pnote.perex-int.cz>
References: <403B9AD0.2050006@softhome.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Feb 2004, Plaz McMan wrote:

> OSS-API emulation does not work properly in 2.6.3 with Loki's 
> UnrealTournament.
> 
> When using kernel 2.6.3 with Loki's UT, the sound is too fast. This is 
> _not_ an issue with 2.6.2. Both kernels are compiled with the same 
> options - ALSA with all OSS emulation options enabled. No native OSS 
> support is compiled in.
> 
> OSS emulation seems to work with other programs, such as xmms, under 
> both kernels.
> 
> A workaround is to compile all sound options as modules, and modprobe 
> ALSA out and OSS in before starting UnrealTournament. This is quite 
> clumsy, though.

Can you try latest 2.6.3-mm kernel?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs
