Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261286AbTAQVZy>; Fri, 17 Jan 2003 16:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261333AbTAQVZy>; Fri, 17 Jan 2003 16:25:54 -0500
Received: from gate.perex.cz ([194.212.165.105]:63734 "EHLO pnote.perex-int.cz")
	by vger.kernel.org with ESMTP id <S261286AbTAQVZx>;
	Fri, 17 Jan 2003 16:25:53 -0500
Date: Fri, 17 Jan 2003 22:34:37 +0100 (CET)
From: Jaroslav Kysela <perex@perex.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Samium Gromoff <deepfire@ibe.miee.ru>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ALSA and isapnp cards
In-Reply-To: <200301171447.h0HElsAR011463@ibe.miee.ru>
Message-ID: <Pine.LNX.4.44.0301172233590.3082-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2003, Samium Gromoff wrote:

>        As of 2.5.58, and since no related changes were introduced, in 2.5.59
>  the build process of alsa/sb16pnp is broken.
>
>        Obviously some callbacks are still unimplemented due to the
>  transition to the new 2.5 isapnp subsystem.
>
>        The thing which made me to write this, is the fact that the situation
>  persists since early 2.5.5x.

We know this and I'm working on this problem.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs

