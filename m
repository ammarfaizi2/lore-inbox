Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265919AbUBKQkq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 11:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265924AbUBKQkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 11:40:45 -0500
Received: from math.ut.ee ([193.40.5.125]:57229 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S265919AbUBKQkk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 11:40:40 -0500
Date: Wed, 11 Feb 2004 18:40:36 +0200 (EET)
From: Meelis Roos <mroos@math.ut.ee>
To: Takashi Iwai <tiwai@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-rc1: snd_intel8x0 still too fast
In-Reply-To: <s5hptclbzf4.wl@alsa2.suse.de>
Message-ID: <Pine.GSO.4.44.0402111839510.19304-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> does the attached patch improve?

Unfortunately not.

> if it still doesn't help, try the following:
>
> - stop ALSA once
> - remove /etc/asound.state
> - restart ALSA and tune up mixer again

Did that (with the new patched driver), still the same.

-- 
Meelis Roos (mroos@ut.ee)      http://www.cs.ut.ee/~mroos/

