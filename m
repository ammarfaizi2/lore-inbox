Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262807AbVCPVVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262807AbVCPVVW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 16:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262806AbVCPVTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 16:19:25 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:4481 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262808AbVCPVSt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 16:18:49 -0500
Date: Wed, 16 Mar 2005 22:18:35 +0100
From: Johannes Stezenbach <js@sig21.net>
To: Peter Hagervall <hager@cs.umu.se>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Message-ID: <20050316211835.GA4526@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@sig21.net>,
	Peter Hagervall <hager@cs.umu.se>, linux-kernel@vger.kernel.org,
	trivial@rustcorp.com.au
References: <20050314105524.GB24325@peppar.cs.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050314105524.GB24325@peppar.cs.umu.se>
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: 217.231.51.130
Subject: Re: =?iso-8859-1?B?W1BBVENIXaBkcml2ZXJz?=
	=?iso-8859-1?Q?=2Fmedia?= Sparse fixes
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2005 at 11:55:24AM +0100, Peter Hagervall wrote:
> Removes some sparse warnings on one-bit bitfields.
> 
> Signed-off-by: Peter Hagervall <hager@cs.umu.se>
> 
> --
> 
>  dvb/dvb-core/dvb_ca_en50221.c |    6 +++---

I applied this one to linuxtv.org CVS.

>  video/cx88/cx88.h             |    4 ++--
>  video/msp3400.c               |    4 ++--
>  video/videocodec.h            |   16 ++++++++--------

These should go to the video4linux maintainer...

Thanks,
Johannes
