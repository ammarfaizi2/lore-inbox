Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbTLBOyn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 09:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbTLBOyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 09:54:43 -0500
Received: from users.linvision.com ([62.58.92.114]:53654 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S261595AbTLBOym (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 09:54:42 -0500
Date: Tue, 2 Dec 2003 15:54:41 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG 2.6.0-test11] debug messages, ALSA or USB related
Message-ID: <20031202145441.GB28315@bitwizard.nl>
References: <20031201233941.GA4017@bitwizard.nl> <s5h8ylve22q.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h8ylve22q.wl@alsa2.suse.de>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 02, 2003 at 03:17:33PM +0100, Takashi Iwai wrote:
> At Tue, 2 Dec 2003 00:39:41 +0100,
> Erik Mouw wrote:
> > 
> > At first glance it looks USB related, but it might as well be that the
> > ALSA code is the real culprit.
> 
> yes, it's a known bug in ALSA's snd-usb-audio driver.
> it was already fixed on the recent version (1.0.0rc1).

OK. I suppose you'll push it to Linus/Andrew soonish?


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
| Data lost? Stay calm and contact Harddisk-recovery.com
