Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbWADLuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWADLuZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 06:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWADLuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 06:50:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56228 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751104AbWADLuY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 06:50:24 -0500
Date: Wed, 4 Jan 2006 03:47:52 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Jaroslav Kysela <perex@suse.cz>
Cc: s0348365@sms.ed.ac.uk, kloczek@rudy.mif.pg.gda.pl, bunk@stusta.de,
       galibert@pobox.com, zdzichu@irc.pl, jengelh@linux01.gwdg.de, ak@suse.de,
       alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, linux@thorsten-knabe.de, zwane@commfireservices.com,
       linux-kernel@vger.kernel.org
Subject: Re: [OT] ALSA userspace API complexity
Message-Id: <20060104034752.2d5c1a78.zaitcev@redhat.com>
In-Reply-To: <Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz>
References: <20050726150837.GT3160@stusta.de>
	<20060103193736.GG3831@stusta.de>
	<Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl>
	<mailman.1136368805.14661.linux-kernel2news@redhat.com>
	<20060104030034.6b780485.zaitcev@redhat.com>
	<Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jan 2006 12:35:25 +0100 (CET), Jaroslav Kysela <perex@suse.cz> wrote:

> [...] We can add a simple (like OSS) API layer 
> into alsa-lib, but I'm not sure, if it's worth to do it.

Probably not worth it. But having more examples like Alistair's in docs
would be a good idea, I expect. The silly patch I quoted is one of
the hottest documents on my webpage. People need this stuff, and
cannot find it.

-- Pete
