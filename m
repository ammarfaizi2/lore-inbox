Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbUC1Jr1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 04:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbUC1Jr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 04:47:27 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:36771 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S262240AbUC1Jr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 04:47:26 -0500
Subject: Re: [linux-usb-devel] Re: [ANNOUNCE] RNDIS Gadget Driver
From: David Woodhouse <dwmw2@infradead.org>
To: don <don_reid@comcast.net>
Cc: David Brownell <david-b@pacbell.net>, Robert Schwebel <robert@schwebel.de>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20040328024712.GA30855@reid.corvallis.or.us>
References: <20040325221145.GJ10711@pengutronix.de>
	 <40636295.7000008@pacbell.net>
	 <1080297466.29835.144.camel@hades.cambridge.redhat.com>
	 <40644FCA.8000206@pacbell.net>
	 <20040326232328.GA29771@reid.corvallis.or.us>
	 <4065B39A.2040003@pacbell.net>
	 <20040328024712.GA30855@reid.corvallis.or.us>
Content-Type: text/plain
Message-Id: <1080467223.17352.77.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.2) 
Date: Sun, 28 Mar 2004 10:47:03 +0100
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-03-27 at 18:47 -0800, don wrote:
> These are applications, not file system interfaces like USB Mass Storage.
> I want to mount the camera or gadget file system and access it from any
> program, not run a separate app to fetch files like Mass Stor. mounts
> a memory device.
> 
> Why create a dedicated app like a camera interface instead of using your
> favorite image browser on some files?

Bear in mind also that the reason I asked is because I want to export
_real_ file systems this way, so you can plug your iPAQ in and access
its file system without having to do it over NFS.

-- 
dwmw2


