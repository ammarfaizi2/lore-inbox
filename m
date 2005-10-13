Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbVJMUFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbVJMUFJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 16:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbVJMUFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 16:05:09 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:58562 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932438AbVJMUFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 16:05:07 -0400
Subject: Re: [PATCH/RFC 2/2] simple SPI controller on PXA2xx SSP port
From: Lee Revell <rlrevell@joe-job.com>
To: stephen@streetfiresound.com
Cc: linux-kernel@vger.kernel.org, David Brownell <david-b@pacbell.net>,
       Takashi Iwai <tiwai@suse.de>
In-Reply-To: <1129232559.11433.8.camel@localhost.localdomain>
References: <43443418.iFtzmi3B9GGDv89Z%stephen@streetfiresound.com>
	 <1129229571.16243.34.camel@mindpipe>
	 <1129232559.11433.8.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 13 Oct 2005 16:04:57 -0400
Message-Id: <1129233898.16243.56.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-13 at 12:42 -0700, Stephen Street wrote:
> On Thu, 2005-10-13 at 14:52 -0400, Lee Revell wrote:
> > Shouln't this live in sound/spi, like the i2c ALSA drivers live in
> > sound/i2c, and not drivers/spi?
> 
> Yes!  This is a preliminary driver designed primarily to
> test/demonstrate the SPI framework and the PXA255 SPI implementation.  I
> will move it when I release a complete CS8415A driver. Soon. 

OK, great.  Make sure to CC alsa-devel at lists.sourceforge.net when you
do.

Lee

