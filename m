Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261406AbVAGNai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbVAGNai (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 08:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbVAGNah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 08:30:37 -0500
Received: from mail.suse.de ([195.135.220.2]:2196 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261406AbVAGNac (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 08:30:32 -0500
To: Takashi Iwai <tiwai@suse.de>
Cc: Soeren Sonnenburg <kernel@nn7.de>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.6.10-rc3 snd-powermac crash
References: <1103389648.5967.7.camel@gaston>
	<pan.2004.12.21.07.53.37.708238@nn7.de> <jezmzuo5jc.fsf@sykes.suse.de>
	<s5hr7kxwit8.wl@alsa2.suse.de>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Yow!  Did something bad happen or am I in a drive-in movie??
Date: Fri, 07 Jan 2005 14:30:31 +0100
In-Reply-To: <s5hr7kxwit8.wl@alsa2.suse.de> (Takashi Iwai's message of "Fri,
 07 Jan 2005 13:00:03 +0100")
Message-ID: <je4qhtjrig.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai <tiwai@suse.de> writes:

> Isn't it the bug which was fixed in 2.6.10-final?
>
> ================================================================
> ChangeSet@1.1938.423.42, 2004-12-22 10:46:54-08:00, tiwai@suse.de
>   [PATCH] alsa: fix oops with ALSA OSS emulation on PPC
> ================================================================

Yes, I guess so.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
