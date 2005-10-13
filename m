Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbVJMVZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbVJMVZg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 17:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbVJMVZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 17:25:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26305 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964855AbVJMVZf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 17:25:35 -0400
Date: Thu, 13 Oct 2005 14:25:18 -0700
From: Chris Wright <chrisw@osdl.org>
To: kernel-stuff@comcast.net
Cc: Christian Krause <chkr@plauener.de>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, chrisw@osdl.org, stable@kernel.org
Subject: Re: [PATCH] Re: bug in handling of highspeed usb HID devices
Message-ID: <20051013212518.GY5856@shell0.pdx.osdl.net>
References: <101320051953.12930.434EBB460007F30B0000328222007589429D0E050B9A9D0E99@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <101320051953.12930.434EBB460007F30B0000328222007589429D0E050B9A9D0E99@comcast.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* kernel-stuff@comcast.net (kernel-stuff@comcast.net) wrote:
> This seems to be -stable material since it's a clear cut bug with bad
> consequences. 
> 
> Chris Wright - is the below patch acceptable for -stable?

This all looks fine.  But two things, please send -stable patches to
stable@kernel.org, and I've not seen an ACK from any usb developers.

thanks,
-chris
