Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161225AbWFVTyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161225AbWFVTyw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 15:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161213AbWFVTyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 15:54:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15085 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932642AbWFVTyv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 15:54:51 -0400
Date: Thu, 22 Jun 2006 12:54:35 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jaroslav Kysela <perex@suse.cz>
cc: Andrew Morton <akpm@osdl.org>, Takashi Iwai <tiwai@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [ALSA PATCH] HG repo - 1.0.12rc1
In-Reply-To: <Pine.LNX.4.61.0606221704040.9048@tm8103.perex-int.cz>
Message-ID: <Pine.LNX.4.64.0606221251510.5498@g5.osdl.org>
References: <Pine.LNX.4.61.0606221704040.9048@tm8103.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 22 Jun 2006, Jaroslav Kysela wrote:
>
> Linus, please do an update from:
> 
>   rsync://rsync.kernel.org/pub/scm/linux/kernel/git/perex/alsa.git

Please don't use "rsync".

Also, this ALSA archive seems to be missing the a lot of Signed-off-by: 
lines. You show up as the committer for all the commits, but they seldom 
have your signed-off line.

Pls fix for next time.

		Linus
