Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266549AbUGKKQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266549AbUGKKQM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 06:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266550AbUGKKQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 06:16:12 -0400
Received: from adsl-153-231.38-151.net24.it ([151.38.231.153]:21255 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id S266549AbUGKKQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 06:16:10 -0400
Date: Sun, 11 Jul 2004 12:16:08 +0200
From: Daniele Venzano <webvenza@libero.it>
To: Jean Francois Martinez <jfm512@free.fr>
Cc: root@chaos.analogic.com, linux-kernel@vger.kernel.org
Subject: Re: Integrated ethernet on SiS chipset doesn't work
Message-ID: <20040711101608.GB10738@picchio.gall.it>
Mail-Followup-To: Jean Francois Martinez <jfm512@free.fr>,
	root@chaos.analogic.com, linux-kernel@vger.kernel.org
References: <1089480939.2779.22.camel@agnes> <Pine.LNX.4.53.0407102141560.5590@chaos> <1089538014.4690.32.camel@agnes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089538014.4690.32.camel@agnes>
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.25-grsec
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 11, 2004 at 11:26:54AM +0200, Jean Francois Martinez wrote:
> 2) The Sis 900 driver is supposed to be _supported_ ie someone is being
> paid for fixing problems.  It has the highest maintenance status so
> its problems are made to be fixed.
The email listed in the MAINTAINERS file bounces, so the driver is not
supported so well, I'm acting as maintainer, but no one is paying me.

The sis900 driver driver works in most cases, I am aware of some issues,
mostly caused by new hardware not known by the driver. These problems,
however, cause slowdowns, but the card is always detected.

So before saying anything let's wait for the poster's dmesg.

Cheers.

-- 
-----------------------------
Daniele Venzano
Web: http://teg.homeunix.org

