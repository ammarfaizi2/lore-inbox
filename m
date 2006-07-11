Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751376AbWGKAjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbWGKAjP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 20:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWGKAjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 20:39:15 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:7131 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751376AbWGKAjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 20:39:14 -0400
Subject: Re: [Alsa-devel] OSS driver removal, 2nd round (v2)
From: Lee Revell <rlrevell@joe-job.com>
To: Olivier Galibert <galibert@pobox.com>
Cc: Adam Tla?ka <atlka@pg.gda.pl>, ak@suse.de, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, perex@suse.cz, alan@lxorguk.ukuu.org.uk
In-Reply-To: <20060710235934.GC26528@dspnet.fr.eu.org>
References: <20060707231716.GE26941@stusta.de>
	 <p737j2potzr.fsf@verdi.suse.de> <1152458300.28129.45.camel@mindpipe>
	 <20060710132810.551a4a8d.atlka@pg.gda.pl>
	 <1152571717.19047.36.camel@mindpipe> <44B2E4FF.9000502@pg.gda.pl>
	 <20060710235934.GC26528@dspnet.fr.eu.org>
Content-Type: text/plain
Date: Mon, 10 Jul 2006 20:39:03 -0400
Message-Id: <1152578344.21909.12.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-11 at 01:59 +0200, Olivier Galibert wrote:
> ALSA lib has something like 7 different methods just to play a sound.
> Their view of "low level" is quite interesting.  Using it is pure
> hell.  Debugging what you've done is worse.  And don't bother to hope
> that your code will still work in six months.
> 

A small FAQ:

Q: But OSS is kewl and ALSA sucks!
A: The decision for the OSS->ALSA move was four years ago.
   If ALSA sucks, please help to improve ALSA.


