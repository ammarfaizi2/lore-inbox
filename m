Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030419AbWARU0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030419AbWARU0Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 15:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030418AbWARU0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 15:26:15 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:31251 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1030415AbWARU0P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 15:26:15 -0500
Date: Wed, 18 Jan 2006 15:25:27 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: Michael Buesch <mbuesch@freenet.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jbenc@suse.cz,
       softmac-dev@sipsolutions.net, bcm43xx-dev@lists.berlios.de
Subject: Re: [Bcm43xx-dev] wireless: the contenders
Message-ID: <20060118202523.GD6583@tuxdriver.com>
Mail-Followup-To: Michael Buesch <mbuesch@freenet.de>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jbenc@suse.cz,
	softmac-dev@sipsolutions.net, bcm43xx-dev@lists.berlios.de
References: <20060118200616.GC6583@tuxdriver.com> <200601182119.20708.mbuesch@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601182119.20708.mbuesch@freenet.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 09:19:20PM +0100, Michael Buesch wrote:
> On Wednesday 18 January 2006 21:06, John W. Linville wrote:
> > The tree also has "softmac" and "dscape" branches.  The "softmac"
> > branch includes the Johannes Berg softmac code as well as the the
> > BCM43xx driver based upon that code.  The "dscape" branch includes
> > the DeviceScape patches from Jiri Benc as well as the BCM43xx driver
> > ported to the DeviceScape stack.
> 
> Are you going to keep it synced with our repository?
> I think it should be possible to automatically send patches for
> every change in our tree to you. I am not 100% sure (but 99%).
> I will look at it tomorrow.

If you'll send me patches, I'll apply them...

John

P.S.  Please do what you can to make them comply w/ kernel patch
posting conventions:

	http://linux.yyz.us/patch-format.html
-- 
John W. Linville
linville@tuxdriver.com
