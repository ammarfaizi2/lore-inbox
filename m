Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264472AbTEaV74 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 17:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264473AbTEaV7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 17:59:55 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:9700 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264472AbTEaV7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 17:59:55 -0400
Date: Sun, 1 Jun 2003 00:13:09 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: zipa24@suomi24.fi, perex@suse.cz, alsa-devel@alsa-project.org
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.70-mm3
Message-ID: <20030531221309.GL29425@fs.tum.de>
References: <Pine.LNX.4.50L0.0306010036140.3349-100000@limbo.dnsalias.org> <3E5AD46C0006FA51@webmail-fi1.sol.no1.asap-asp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E5AD46C0006FA51@webmail-fi1.sol.no1.asap-asp.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 01, 2003 at 12:45:02AM +0300, zipa24@suomi24.fi wrote:
> >On Sat, 31 May 2003, Andrew Morton wrote:
> 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.70/2.5.70-mm3/
> 
> I get following OOPS when I try to load snd-ymfpci ALSA module:
>...

Debian bug #193077 [1] lists a similar problem with current ALSA and 
kernel 2.4 ...

cu
Adrian

[1] http://bugs.debian.org/193077

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

