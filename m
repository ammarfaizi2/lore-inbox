Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261903AbUL0PWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbUL0PWf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 10:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbUL0PWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 10:22:35 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:41627 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261903AbUL0PWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 10:22:01 -0500
Subject: Re: [Alsa-devel] PATCH: 2.6.10: i810 more AC97 tunings
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Takashi Iwai <tiwai@suse.de>
Cc: torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       alsa-devel@alsa-project.org
In-Reply-To: <s5hpt0vde7j.wl@alsa2.suse.de>
References: <1104104497.16487.12.camel@localhost.localdomain>
	 <s5hpt0vde7j.wl@alsa2.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104157078.20952.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 27 Dec 2004 14:18:01 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-12-27 at 14:10, Takashi Iwai wrote:
> At Sun, 26 Dec 2004 23:41:38 +0000,
> Alan Cox wrote:
> > 
> > Add some more funky AC97 knowledge to the intel8x0 driver. These come
> > from Red Hat and its partners and are included in our shipping code.
> 
> These entries seem to be already included in 2.6.10.
> Note that the quirk list is sorted in the order of vendor id.


Thanks. Will double check and drop.

