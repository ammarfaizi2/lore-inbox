Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264605AbUAEPrz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 10:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbUAEPp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 10:45:57 -0500
Received: from hauptpostamt.charite.de ([193.175.66.220]:18398 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S265165AbUAEPpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 10:45:09 -0500
Date: Mon, 5 Jan 2004 16:41:21 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: ALSA error?
Message-ID: <20040105154121.GI27195@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040104160954.GE27197@charite.de> <s5hfzeu2z83.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <s5hfzeu2z83.wl@alsa2.suse.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Takashi Iwai <tiwai@suse.de>:

> if you hear normal playback sounds, you don't have to worry too much
> about this.

Good!

> it's a warning for the sloppy interrupts, and will be
> disabled if you compile without CONFIG_SND_DEBUG.

Yep. The next kernel will have that :)

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-916
Referat V a - Kommunikationsnetze -             AIM.  ralfpostfix
