Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965155AbWADADs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965155AbWADADs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 19:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965152AbWADADs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 19:03:48 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:6674 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965154AbWADADq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 19:03:46 -0500
Date: Wed, 4 Jan 2006 01:03:44 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Tomasz K?oczko <kloczek@rudy.mif.pg.gda.pl>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Takashi Iwai <tiwai@suse.de>,
       Olivier Galibert <galibert@pobox.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Andi Kleen <ak@suse.de>,
       perex@suse.cz, alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Message-ID: <20060104000344.GJ3831@stusta.de>
References: <200601031629.21765.s0348365@sms.ed.ac.uk> <20060103170316.GA12249@dspnet.fr.eu.org> <s5h1wzpnjrx.wl%tiwai@suse.de> <20060103203732.GF5262@irc.pl> <s5hvex1m472.wl%tiwai@suse.de> <9a8748490601031256x916bddav794fecdcf263fb55@mail.gmail.com> <20060103215654.GH3831@stusta.de> <20060103221314.GB23175@irc.pl> <20060103231009.GI3831@stusta.de> <Pine.BSO.4.63.0601040048010.29027@rudy.mif.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.BSO.4.63.0601040048010.29027@rudy.mif.pg.gda.pl>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 12:51:52AM +0100, Tomasz K?oczko wrote:
> On Wed, 4 Jan 2006, Adrian Bunk wrote:
> [..]
> >>  OSS is universal cross-unix API. ALSA is Linux-only.
> >
> >How "universal cross-unix" is the OSS API really?
> >
> >Which operating systems besides Linux have a native sound system
> >supporting the OSS API [1]?
> >
> >I know about FreeBSD and partial support in NetBSD.
> >
> >Are there any other [2]?
> 
> Solaris, AIX ..
> Full list is avalaible in "Operating System" listbox on 
> http://www.4front-tech.com/download.cgi

As I said in footnote 1 of my email, this has little value for 
application developers since only few users on these systems use this 
commercial sound system.

> kloczek

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

