Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261399AbVAGNCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbVAGNCA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 08:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbVAGNCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 08:02:00 -0500
Received: from prosun.first.fraunhofer.de ([194.95.168.2]:2509 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S261399AbVAGNBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 08:01:42 -0500
Subject: Re: [BUG] 2.6.10-rc3 snd-powermac crash
From: Soeren Sonnenburg <kernel@nn7.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: Andreas Schwab <schwab@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <s5hr7kxwit8.wl@alsa2.suse.de>
References: <1103389648.5967.7.camel@gaston>
	 <pan.2004.12.21.07.53.37.708238@nn7.de> <jezmzuo5jc.fsf@sykes.suse.de>
	 <s5hr7kxwit8.wl@alsa2.suse.de>
Content-Type: text/plain
Date: Fri, 07 Jan 2005 14:00:44 +0100
Message-Id: <1105102844.6721.27.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-07 at 13:00 +0100, Takashi Iwai wrote:
> At Fri, 31 Dec 2004 16:23:35 +0100,
> Andreas Schwab wrote:
> > 
> > Soeren Sonnenburg <kernel@nn7.de> writes:
> > 
> > > I also get the very same oops - though very rarely - with pbbuttons and
> > > kernel 2.6.9 on my 1GHz-pbook 15"
> > 
> > I have been using ALSA on my G3 iBook already for a long time and never
> > saw this.  I didn't try 2.6.10 yet, though.
> 
> Isn't it the bug which was fixed in 2.6.10-final?
> 
> ================================================================
> ChangeSet@1.1938.423.42, 2004-12-22 10:46:54-08:00, tiwai@suse.de
>   [PATCH] alsa: fix oops with ALSA OSS emulation on PPC
> ================================================================

well yes, that is what at least I thought...

Soeren
-- 
Sometimes, there's a moment as you're waking, when you become aware of
the real world around you, but you're still dreaming.

