Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbWGIQI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbWGIQI0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 12:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbWGIQI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 12:08:26 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:42258 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S932210AbWGIQI0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 12:08:26 -0400
Date: Sun, 9 Jul 2006 18:08:25 +0200
From: Olivier Galibert <galibert@pobox.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andi Kleen <ak@suse.de>, Adrian Bunk <bunk@stusta.de>,
       alsa-devel@alsa-project.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       perex@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [Alsa-devel] OSS driver removal, 2nd round (v2)
Message-ID: <20060709160825.GA54787@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Lee Revell <rlrevell@joe-job.com>, Andi Kleen <ak@suse.de>,
	Adrian Bunk <bunk@stusta.de>, alsa-devel@alsa-project.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, perex@suse.cz,
	linux-kernel@vger.kernel.org
References: <20060707231716.GE26941@stusta.de> <p737j2potzr.fsf@verdi.suse.de> <1152458300.28129.45.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152458300.28129.45.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2006 at 11:18:19AM -0400, Lee Revell wrote:
> It doesn't do the same thing - software mixing is impossible with OSS.

It's exactly as impossible with OSS as it is with ALSA.  Just stop
considering the OSS API support the problem child of the family and
these removals will go *much* easier, you know?

  OG.
