Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261894AbUKVB5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261894AbUKVB5Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 20:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbUKVB5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 20:57:16 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:60866 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261894AbUKVB5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 20:57:14 -0500
Subject: Re: [2.6 patch] ALSA PCI drivers: misc cleanups
From: Lee Revell <rlrevell@joe-job.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: perex@suse.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20041121235855.GI13254@stusta.de>
References: <20041121235855.GI13254@stusta.de>
Content-Type: text/plain
Date: Sun, 21 Nov 2004 20:57:12 -0500
Message-Id: <1101088632.5119.2.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-22 at 00:58 +0100, Adrian Bunk wrote:
>   - emu10k1/io.c: snd_emu10k1_voice_set_loop_stop

Please do not remove this function.  I am working on an enhancement to
the emu10k1 driver that uses it.

Thanks,

Lee

