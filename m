Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261784AbVB1WUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbVB1WUW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 17:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbVB1WUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 17:20:21 -0500
Received: from fire.osdl.org ([65.172.181.4]:58558 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261784AbVB1WUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 17:20:15 -0500
Date: Mon, 28 Feb 2005 14:20:11 -0800
From: Chris Wright <chrisw@osdl.org>
To: micah milano <micaho@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CAN-2005-0204]: AMD64, allows local users to write to privileged IO ports via OUTS instruction
Message-ID: <20050228222011.GH28536@shell0.pdx.osdl.net>
References: <70fda32050228132743998647@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70fda32050228132743998647@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* micah milano (micaho@gmail.com) wrote:
> CAN-2005-0204 reads:

[snip]

> This apparantly only affects AMD64 and EM64T.

It also does not effect mainstream kernels.  IIRC, it turns out to be
a problem introduced with 4G/4G patch which is not in mainline.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
