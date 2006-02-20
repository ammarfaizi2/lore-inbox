Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbWBTA5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbWBTA5N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 19:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWBTA5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 19:57:12 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:42138 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751171AbWBTA5L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 19:57:11 -0500
Date: Sun, 19 Feb 2006 16:57:07 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Pavel Machek <pavel@suse.cz>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Nick Warne <nick@linicks.net>, Jesper Juhl <jesper.juhl@gmail.com>,
       tiwai@suse.de, ghrt@dial.kappa.ro, perex@suse.cz,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: No sound from SB live!
Message-ID: <20060220005707.GC5976@us.ibm.com>
References: <20060218231419.GA3219@elf.ucw.cz> <20060219214702.GM15311@elf.ucw.cz> <1140385837.2733.394.camel@mindpipe> <200602192323.08169.s0348365@sms.ed.ac.uk> <1140391929.2733.430.camel@mindpipe> <20060219234644.GD15608@elf.ucw.cz> <1140393222.2733.438.camel@mindpipe> <20060220000426.GB5976@us.ibm.com> <1140394268.2733.443.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140394268.2733.443.camel@mindpipe>
X-Operating-System: Linux 2.6.16-rc4 (x86_64)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.02.2006 [19:11:08 -0500], Lee Revell wrote:
> On Sun, 2006-02-19 at 16:04 -0800, Nishanth Aravamudan wrote:
> > root@arkanoid:/home/nacc# aptitude search alsa | grep ^i
> > i   alsa-base                       - ALSA driver configuration files
> > i   alsa-utils                      - ALSA utilities
> > root@arkanoid:/home/nacc# aptitude search alsa | grep lib
> > v   alsalib                         -
> > v   alsalib0.1.3                    -
> > v   alsalib0.3.0                    -
> > v   alsalib0.3.0-dev                -
> > v   alsalib0.3.2                    -
> > v   alsalib0.3.2-dev                -
> > 
> 
> Some distros call it "libasound".

Ah ha! Thanks, Lee.

alsa-lib = 1.0.9-2

Thanks,
Nish
