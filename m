Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932475AbWBTALN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbWBTALN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 19:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbWBTALN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 19:11:13 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:50374 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932475AbWBTALM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 19:11:12 -0500
Subject: Re: No sound from SB live!
From: Lee Revell <rlrevell@joe-job.com>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: Pavel Machek <pavel@suse.cz>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Nick Warne <nick@linicks.net>, Jesper Juhl <jesper.juhl@gmail.com>,
       tiwai@suse.de, ghrt@dial.kappa.ro, perex@suse.cz,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060220000426.GB5976@us.ibm.com>
References: <20060218231419.GA3219@elf.ucw.cz>
	 <20060219214702.GM15311@elf.ucw.cz> <1140385837.2733.394.camel@mindpipe>
	 <200602192323.08169.s0348365@sms.ed.ac.uk>
	 <1140391929.2733.430.camel@mindpipe> <20060219234644.GD15608@elf.ucw.cz>
	 <1140393222.2733.438.camel@mindpipe>  <20060220000426.GB5976@us.ibm.com>
Content-Type: text/plain
Date: Sun, 19 Feb 2006 19:11:08 -0500
Message-Id: <1140394268.2733.443.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-19 at 16:04 -0800, Nishanth Aravamudan wrote:
> root@arkanoid:/home/nacc# aptitude search alsa | grep ^i
> i   alsa-base                       - ALSA driver configuration files
> i   alsa-utils                      - ALSA utilities
> root@arkanoid:/home/nacc# aptitude search alsa | grep lib
> v   alsalib                         -
> v   alsalib0.1.3                    -
> v   alsalib0.3.0                    -
> v   alsalib0.3.0-dev                -
> v   alsalib0.3.2                    -
> v   alsalib0.3.2-dev                -
> 

Some distros call it "libasound".

Lee

