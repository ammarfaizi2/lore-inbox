Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbVHVVzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbVHVVzA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 17:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbVHVVzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 17:55:00 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:14573 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750779AbVHVVy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 17:54:59 -0400
Subject: Re: [Alsa-devel] Re: [Alsa drivers] Creatives X-Fi chip
From: Lee Revell <rlrevell@joe-job.com>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, Emmanuel Fleury <fleury@cs.aau.dk>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       alsa-devel@lists.sourceforge.net
In-Reply-To: <430A37B5.9050300@superbug.co.uk>
References: <4305AC77.3010907@cs.aau.dk>
	 <1124491956.25424.95.camel@mindpipe>	<4306D254.3000401@cs.aau.dk>
	 <1124521688.26949.15.camel@mindpipe> <s5hirxyp3kh.wl%tiwai@suse.de>
	 <430A37B5.9050300@superbug.co.uk>
Content-Type: text/plain
Date: Mon, 22 Aug 2005 17:54:55 -0400
Message-Id: <1124747695.16064.46.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.7 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-22 at 21:38 +0100, James Courtier-Dutton wrote:
> We are not going to get any support from Creative for the X-Fi chip.
> We do not get support from Creative for any Creative chip that has a
> DSP in it. 

Well, except for the emu10k1 driver that Creative wrote and released
years ago.  I don't see why they can't do something similar with the
X-Fi stuff.  We don't need or expect the DSP programming docs, just the
minimum to get sound in and out of the thing.

So do you expect Creative to leave thousands of emu10k1/emu10k2 Linux
users with no upgrade path?  I think if they tried to do this we could
make it a real PR nightmare for them.

Lee

