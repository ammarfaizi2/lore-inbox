Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966382AbWKTSwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966382AbWKTSwz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 13:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966395AbWKTSwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 13:52:55 -0500
Received: from nlpi029.sbcis.sbc.com ([207.115.36.58]:6866 "EHLO
	nlpi029.sbcis.sbc.com") by vger.kernel.org with ESMTP
	id S966382AbWKTSwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 13:52:54 -0500
X-ORBL: [67.117.73.34]
Date: Mon, 20 Nov 2006 18:52:22 +0000
From: Tony Lindgren <tony@atomide.com>
To: Komal Shah <komal.shah802003@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       Vladimir Ananiev <vovan888@gmail.com>
Subject: Re: Siemens SX1: sound cleanups
Message-ID: <20061120185222.GC4597@atomide.com>
References: <20061119114938.GA22514@elf.ucw.cz> <s5h4psus8n9.wl%tiwai@suse.de> <3a5b1be00611200446m69d1c593qa13649ff6b9f0506@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a5b1be00611200446m69d1c593qa13649ff6b9f0506@mail.gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Komal Shah <komal.shah802003@gmail.com> [061120 12:46]:
> On 11/20/06, Takashi Iwai <tiwai@suse.de> wrote:
> >At Sun, 19 Nov 2006 12:49:38 +0100,
> >Pavel Machek wrote:
> >>
> >> Hi!
> >>
> >> These are cleanups for codingstyle in sound parts of siemens sx1. They
> >> should not change any code. Please apply,
> >>
> >>                                                               Pavel
> >
> >Which tree does include these drivers?
> >I've never seen nor review it...
> 
> It's Linux Texas Instruments OMAP processors tree, hosted at following 
> links:
> 
> http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=log
> 
> OR mirror copy is also available to view at
> 
> http://www.kernel.org/git/
> 
> You have not seen those drivers, because we have _not_ yet submitted
> ALSA drivers for aic23 and ts2102 to upstream.

Yeah, we should clean-up and those for sending to alsa list for merging.

Tony
