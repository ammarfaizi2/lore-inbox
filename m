Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266417AbUBLNku (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 08:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266420AbUBLNkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 08:40:49 -0500
Received: from math.ut.ee ([193.40.5.125]:28914 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S266417AbUBLNks (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 08:40:48 -0500
Date: Thu, 12 Feb 2004 15:40:41 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Takashi Iwai <tiwai@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-rc1: snd_intel8x0 still too fast
In-Reply-To: <s5hlln9a049.wl@alsa2.suse.de>
Message-ID: <Pine.GSO.4.44.0402121540270.22808-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> oops, the patch was wrong.  could you try this one (and remove
> /etc/asound.state before starting ALSA?)

This one works, thanks!

-- 
Meelis Roos (mroos@linux.ee)

