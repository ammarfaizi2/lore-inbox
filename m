Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261615AbULFSoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbULFSoW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 13:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbULFSoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 13:44:22 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:10907 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261611AbULFSoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 13:44:14 -0500
Subject: Re: [2.6 patch] ALSA: misc cleanups
From: Lee Revell <rlrevell@joe-job.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: perex@suse.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20041206001221.GG2953@stusta.de>
References: <20041206001221.GG2953@stusta.de>
Content-Type: text/plain
Date: Mon, 06 Dec 2004 13:44:10 -0500
Message-Id: <1102358650.2897.6.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-06 at 01:12 +0100, Adrian Bunk wrote:
>   - sound/synth/emux/emux_synth.c: snd_emux_release_voice

Hmm, this should be used.  I will check it out.

>   - sound/synth/emux/soundfont.: snd_soundfont_mem_used

This one should be used also.

Lee



