Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbUCPOSL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 09:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbUCPOSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:18:10 -0500
Received: from math.ut.ee ([193.40.5.125]:65532 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261703AbUCPODN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:03:13 -0500
Date: Tue, 16 Mar 2004 16:00:18 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Takashi Iwai <tiwai@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Sound core broken on sparc64 (2.6.4+bk)
In-Reply-To: <s5hk71kgb7h.wl@alsa2.suse.de>
Message-ID: <Pine.GSO.4.44.0403161558130.20991-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> grrr, it's a typo of SNDRV_DMA_TYPE_DEV.

There's als a missing comma at the end of the next line. With this too
fixed, it finally compiles.

-- 
Meelis Roos (mroos@linux.ee)

