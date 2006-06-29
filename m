Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932709AbWF2K4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932709AbWF2K4u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 06:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932770AbWF2K4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 06:56:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19870 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932729AbWF2K4t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 06:56:49 -0400
Date: Thu, 29 Jun 2006 03:56:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@suse.cz, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [ALSA PATCH] HG repo sync
Message-Id: <20060629035627.a073290f.akpm@osdl.org>
In-Reply-To: <s5h4py4p7lz.wl%tiwai@suse.de>
References: <Pine.LNX.4.61.0606291138030.10575@tm8103-a.perex-int.cz>
	<20060629025306.455c89ce.akpm@osdl.org>
	<s5h4py4p7lz.wl%tiwai@suse.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2006 12:40:56 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> >  The tree I
> > get from
> > git+ssh://master.kernel.org/pub/scm/linux/kernel/git/perex/alsa-current.git
> > has quite different changes in it.
> 
> Yes, alsa-current git contains more changes currently in ALSA HG
> repo.  alsa git contains only (safe and important) changes for
> upstream.

I'll grab the mercurial tree, assuming that has everything in it?

How does one turn that into a patch against mainline?
