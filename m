Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751688AbWADLFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688AbWADLFY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 06:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751692AbWADLFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 06:05:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:8328 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751682AbWADLFW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 06:05:22 -0500
Date: Wed, 4 Jan 2006 03:00:34 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       <kloczek@rudy.mif.pg.gda.pl>
Cc: Adrian Bunk <bunk@stusta.de>, Olivier Galibert <galibert@pobox.com>,
       Tomasz Torcz <zdzichu@irc.pl>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Andi Kleen <ak@suse.de>, perex@suse.cz, alsa-devel@alsa-project.org,
       James@superbug.demon.co.uk, sailer@ife.ee.ethz.ch,
       linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
       parisc-linux@lists.parisc-linux.org, jgarzik@pobox.com,
       Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
       zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [OT] ALSA userspace API complexity
Message-Id: <20060104030034.6b780485.zaitcev@redhat.com>
In-Reply-To: <mailman.1136368805.14661.linux-kernel2news@redhat.com>
References: <20050726150837.GT3160@stusta.de>
	<20060103193736.GG3831@stusta.de>
	<Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl>
	<mailman.1136368805.14661.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jan 2006 09:37:55 +0000, Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:

> > 2) ALSA API is to complicated: most applications opens single sound
> >    stream.
> 
> FUD and nonsense. []
> http://devzero.co.uk/~alistair/alsa/

That's the kicker, isn't it? Once you get used to it, it's a workable
API, if kinky and verbose. I have a real life example, too:
 http://people.redhat.com/zaitcev/linux/mpg123-0.59r-p3.diff
But arriving on the solution costed a lot of torn hair. Look at this
bald head here! And who is going to pay my medical bills when ALSA
causes me ulcers, Jaroslav?

-- Pete
