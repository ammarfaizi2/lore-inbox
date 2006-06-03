Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751745AbWFCRke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbWFCRke (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 13:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751748AbWFCRke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 13:40:34 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:31107 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751745AbWFCRkd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 13:40:33 -0400
Date: Sat, 3 Jun 2006 10:41:15 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Jens Axboe <axboe@suse.de>
Cc: Marcel Holtmann <marcel@holtmann.org>, Chris Wright <chrisw@sous-sol.org>,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgewood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Mark Lord <liml@rtr.ca>,
       Jeff Garzik <jeff@garzik.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH 07/11] the latest consensus libata resume fix
Message-ID: <20060603174115.GW18769@moss.sous-sol.org>
References: <20060602194618.482948000@sous-sol.org> <20060602194742.420464000@sous-sol.org> <20060602195046.GO4400@suse.de> <1149324575.19311.11.camel@localhost> <20060603132215.GQ4400@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060603132215.GQ4400@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jens Axboe (axboe@suse.de) wrote:
> On Sat, Jun 03 2006, Marcel Holtmann wrote:
> > I had problems with resume on my IBM X41 since I got it (something
> > around 2.6.15) and only this patch made it work again.
> > 
> > Because of the SDHCI stuff I always used the latest kernel and thus I
> > wasn't sure if there actually was a problem or not. So I tested a plain
> > 2.6.16 with and without this patch. The plain 2.6.16 doesn't resume on
> > my IBM X41 laptop. If I apply this patch, the resume works perfect.
> 
> Ok, no problem from my end then.

Thanks guys.
-chris
