Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262528AbVCIXFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262528AbVCIXFT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 18:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262544AbVCIXDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 18:03:36 -0500
Received: from fire.osdl.org ([65.172.181.4]:27108 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262353AbVCIWbR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 17:31:17 -0500
Date: Wed, 9 Mar 2005 14:31:10 -0800
From: Chris Wright <chrisw@osdl.org>
To: Dave Airlie <airlied@linux.ie>
Cc: stable@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] drm missing memset can crash X server..
Message-ID: <20050309223110.GE5389@shell0.pdx.osdl.net>
References: <Pine.LNX.4.58.0503092217240.17853@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503092217240.17853@skynet>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dave Airlie (airlied@linux.ie) wrote:
> 
> Egbert Eich reported a bug 2673 on bugs.freedesktop.org and tracked it
> down to a missing memset in the setversion ioctl, this causes X server
> crashes...
> 
> From: Egbert Eich <eich@pdx.freedesktop.org>
> Signed-off-by: Dave Airlie <airlied@linux.ie>

Thanks, queued to -stable.
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
