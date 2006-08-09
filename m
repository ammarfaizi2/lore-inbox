Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751418AbWHIWt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbWHIWt3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 18:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbWHIWt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 18:49:29 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:33987 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751418AbWHIWt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 18:49:28 -0400
Subject: Re: ALSA problems with 2.6.18-rc3
From: Lee Revell <rlrevell@joe-job.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org,
       Andrew Benton <b3nt@ukonline.co.uk>, Takashi Iwai <tiwai@suse.de>,
       alsa-devel <alsa-devel@lists.sourceforge.net>
In-Reply-To: <200608092328.47039.s0348365@sms.ed.ac.uk>
References: <44D8F3E5.5020508@ukonline.co.uk>
	 <200608092307.27615.s0348365@sms.ed.ac.uk>
	 <1155161498.26338.216.camel@mindpipe>
	 <200608092328.47039.s0348365@sms.ed.ac.uk>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 18:49:32 -0400
Message-Id: <1155163773.26338.226.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-09 at 23:28 +0100, Alistair John Strachan wrote:
> I think this argument is mostly deflated by the fact that other 
> multimedia-centric operating systems do not ship with controls muted.
> If hardware is detected, all sliders are set to 50%. I think this is
> superior. 

The developers audio drivers for other operating systems have full
access to the documentation of all the hardware they support, so it's
possible for them to establish "working" defaults for every device.

Lee

