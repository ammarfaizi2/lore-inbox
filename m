Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266488AbUHVHgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266488AbUHVHgV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 03:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266505AbUHVHgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 03:36:21 -0400
Received: from gate.perex.cz ([82.113.61.162]:28652 "EHLO mail.perex.cz")
	by vger.kernel.org with ESMTP id S266488AbUHVHgU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 03:36:20 -0400
Date: Sun, 22 Aug 2004 09:27:57 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Julien BLACHE <jb@jblache.org>
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: Re: [PATCH 2.6] [SOUND] Add back beep support to snd-powermac
In-Reply-To: <87fz6g6u82.fsf@frigate.technologeek.org>
Message-ID: <Pine.LNX.4.58.0408220918500.1778@pnote.perex-int.cz>
References: <87fz6g6u82.fsf@frigate.technologeek.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Aug 2004, Julien BLACHE wrote:

> Hi,
> 
> The attached patch adds back the beep support to sound/ppc/pmac.c, aka
> snd-powermac, and adds a dependency on INPUT in sound/ppc/Kconfig (for
> obvious reason, read on :).

A similar patch is already in our ALSA tree (thus in -mm kernels).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
