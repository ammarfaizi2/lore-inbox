Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967969AbWK3XKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967969AbWK3XKY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 18:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967972AbWK3XKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 18:10:24 -0500
Received: from nlpi012.sbcis.sbc.com ([207.115.36.41]:34906 "EHLO
	nlpi012.sbcis.sbc.com") by vger.kernel.org with ESMTP
	id S967969AbWK3XKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 18:10:22 -0500
X-ORBL: [67.117.73.34]
Date: Thu, 30 Nov 2006 15:09:42 -0800
To: Pavel Machek <pavel@ucw.cz>
Cc: Takashi Iwai <tiwai@suse.de>, kernel list <linux-kernel@vger.kernel.org>,
       Vladimir Ananiev <vovan888@gmail.com>,
       linux-omap <linux-omap-open-source@linux.omap.com>
Subject: Re: sx1 mixer support
Message-ID: <20061130230942.GH9605@atomide.com>
References: <20061124111445.GA5940@elf.ucw.cz> <s5hk61lf4w3.wl%tiwai@suse.de> <20061124125040.GE5608@elf.ucw.cz> <s5hac2hf169.wl%tiwai@suse.de> <20061130170402.GB1860@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061130170402.GB1860@elf.ucw.cz>
User-Agent: Mutt/1.5.12-2006-07-14
From: tony@atomide.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [061130 09:04]:
> Hi!
> 
> > > Apparently they do not. Fixed.
> > 
> > They are still globals.  Could be static, right?
> 
> Yes, fixed.

Pushing this version to linux-omap after a bit more tabifying.

Tony
