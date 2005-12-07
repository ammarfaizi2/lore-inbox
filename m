Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964936AbVLGX65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbVLGX65 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 18:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965027AbVLGX65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 18:58:57 -0500
Received: from relay03.pair.com ([209.68.5.17]:6158 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S964936AbVLGX64 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 18:58:56 -0500
X-pair-Authenticated: 67.163.102.102
From: Chase Venters <chase.venters@clientec.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Linux in a binary world... a doomsday scenario
Date: Wed, 7 Dec 2005 17:59:14 -0600
User-Agent: KMail/1.8.1
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
References: <1133779953.9356.9.camel@laptopd505.fenrus.org> <1133996869.544.112.camel@localhost.localdomain> <9e4733910512071541s1a6215d9pb166bb27e2c579f9@mail.gmail.com>
In-Reply-To: <9e4733910512071541s1a6215d9pb166bb27e2c579f9@mail.gmail.com>
Organization: Clientec, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512071759.14958.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 December 2005 05:41 pm, Jon Smirl wrote:
> Can the Linux community justify using ruthless means to force
> documentation out of vendors? Asking politely doesn't seem to be
> working -  I suspect it may take something of this magnitude to force
> a change out of NVidia/ATI.

Is this a vote? Cause you have mine. :)

Seriously, there is a danger in the move being seen by the press as too 
adversarial, but with everything I've been reading and seeing lately, I'm 
starting to think that the NVidia/ATI situation may be the single largest 
danger to Linux.

I'm sorry to have not followed the entire "Small PCI Core Patch" thread and 
reference it anyway, but would any device class in Linux be in *near* as much 
danger as the video drivers if Greg's patch was a reality? I seem to have the 
impression that there would be alternative wireless drivers, SCSI drivers, 
etc... 

I think you'd want to try to be more political, naturally. It could start by 
gently suggesting to NVIDIA or ATI that they join a patent commons project 
(where these offensive patents will also reside). They open their driver and 
agree to allow the open source driver to use their patents, then in return 
the commons agrees to defend them from backlash.

But that might not work - things might just heat up. Who would you go after 
first - NVIDIA or ATI? The underdog or the current leader? A threat of losing 
your market leadership, or of being seriously beaten while you are already 
down?

If we got an open graphics driver from one of these two (or, hell, even the 
ability to make one), I would hope that would give us the boost we need to, 
after a short while, finish kicking binary drivers out for good.

But perhaps I'm still dreaming.

- Chase
