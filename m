Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262762AbUKRNVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262762AbUKRNVo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 08:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbUKRNVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 08:21:43 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:40413 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262762AbUKRNUn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 08:20:43 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 18 Nov 2004 14:03:12 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Michael Hunold <hunold@convergence.de>
Subject: Re: Fw: Re: Linux 2.6.10-rc2 [dvb-bt8xx unload oops]
Message-ID: <20041118130312.GE19568@bytesex>
References: <20041116014350.54500549.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041116014350.54500549.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is vanilla 2.6.10-rc2 on P4. This was a problem with -rc1 but

Yes, looks very simliar ...

> some patches off the list [attached] fixed it. I expected these to be
> in -rc2, I am not able to say which patch is missing.

Uhm, strange.  The bttv patches _are_ merged.
Not sure about any for dvb-bt8xx, Michael?

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)
