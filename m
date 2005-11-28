Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbVK1W43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbVK1W43 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 17:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbVK1W43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 17:56:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4833 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932274AbVK1W42 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 17:56:28 -0500
Date: Mon, 28 Nov 2005 14:56:22 -0800
From: Chris Wright <chrisw@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>,
       stable@kernel.org
Subject: Re: [stable] stable review patch - ALSA ALC800 codec
Message-ID: <20051128225622.GG5856@shell0.pdx.osdl.net>
References: <1132834994.20390.4.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132834994.20390.4.camel@mindpipe>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Lee Revell (rlrevell@joe-job.com) wrote:
> This fixes an apparent copy and paste bug that has really been causing
> problems for a lot of users.  It closes ~10 different ALSA bug reports,
> see #1563 for example.  Please apply ASAP for -stable.

Please resend when this is fixed in Linus' tree.  Also, some patch
nitpicks...make sure to add From: line to first line of changelog
comments to keep proper authorship when you are forwarding someone
else's patch, and make sure it applies to kernel tree please
(s/alsa-kernel/sound/ for example).

thanks,
-chris
