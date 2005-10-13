Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbVJMTmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbVJMTmp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 15:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbVJMTmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 15:42:44 -0400
Received: from streetfiresound.liquidweb.com ([64.91.233.29]:58048 "EHLO
	host.streetfiresound.liquidweb.com") by vger.kernel.org with ESMTP
	id S932159AbVJMTmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 15:42:44 -0400
Subject: Re: [PATCH/RFC 2/2] simple SPI controller on PXA2xx SSP port
From: Stephen Street <stephen@streetfiresound.com>
Reply-To: stephen@streetfiresound.com
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org, David Brownell <david-b@pacbell.net>,
       Takashi Iwai <tiwai@suse.de>
In-Reply-To: <1129229571.16243.34.camel@mindpipe>
References: <43443418.iFtzmi3B9GGDv89Z%stephen@streetfiresound.com>
	 <1129229571.16243.34.camel@mindpipe>
Content-Type: text/plain
Organization: StreetFire Sound Labs
Date: Thu, 13 Oct 2005 12:42:39 -0700
Message-Id: <1129232559.11433.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-16) 
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.streetfiresound.liquidweb.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - streetfiresound.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-13 at 14:52 -0400, Lee Revell wrote:
> Shouln't this live in sound/spi, like the i2c ALSA drivers live in
> sound/i2c, and not drivers/spi?

Yes!  This is a preliminary driver designed primarily to
test/demonstrate the SPI framework and the PXA255 SPI implementation.  I
will move it when I release a complete CS8415A driver. Soon. 

-Stephen

