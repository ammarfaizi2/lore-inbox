Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbWA3Kie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWA3Kie (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 05:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWA3Kie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 05:38:34 -0500
Received: from topsns.toshiba-tops.co.jp ([202.230.225.5]:6943 "HELO
	topsns.toshiba-tops.co.jp") by vger.kernel.org with SMTP
	id S932205AbWA3Kid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 05:38:33 -0500
Date: Mon, 30 Jan 2006 19:38:29 +0900 (JST)
Message-Id: <20060130.193829.112261566.nemoto@toshiba-tops.co.jp>
To: tiwai@suse.de
Cc: hugh@veritas.com, linux-kernel@vger.kernel.org, tbm@cyrius.com,
       t.sailer@alumni.ethz.ch, perex@suse.cz, ralf@linux-mips.org
Subject: Re: ALSA on MIPS platform
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <s5hoe1u3to1.wl%tiwai@suse.de>
References: <s5h7j8l64ua.wl%tiwai@suse.de>
	<20060130.185608.30186596.nemoto@toshiba-tops.co.jp>
	<s5hoe1u3to1.wl%tiwai@suse.de>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 30 Jan 2006 11:18:54 +0100, Takashi Iwai <tiwai@suse.de> said:
tiwai> Well, as Hugu pointed out, that page reservation plays no longer any
tiwai> role.  The patch below should work too on 2.6.15 or later.

The patch works for me.  Thank you.

Acked-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

---
Atsushi Nemoto
