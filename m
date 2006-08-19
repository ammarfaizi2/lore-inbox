Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422659AbWHSAQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422659AbWHSAQy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 20:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422658AbWHSAQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 20:16:54 -0400
Received: from mga05.intel.com ([192.55.52.89]:50597 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1422659AbWHSAQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 20:16:53 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,147,1154934000"; 
   d="scan'208"; a="118344268:sNHT16760611"
Date: Fri, 18 Aug 2006 17:16:41 -0700
From: Valerie Henson <val_henson@linux.intel.com>
To: Pozsar Balazs <pozsy@uhulinux.hu>
Cc: Prakash Punnoor <prakash@punnoor.de>, Jiri Benc <jbenc@suse.cz>,
       LKML <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
Subject: Re: [RFC/PATCH] Fixes for ULi5261 (tulip driver)
Message-ID: <20060819001640.GE20111@goober>
References: <20050427124911.6212670f@griffin.suse.cz> <20060816191139.5d13fda8@griffin.suse.cz> <20060816174329.GC17650@ojjektum.uhulinux.hu> <200608162002.06793.prakash@punnoor.de> <20060816195345.GA12868@ojjektum.uhulinux.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060816195345.GA12868@ojjektum.uhulinux.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 09:53:45PM +0200, Pozsar Balazs wrote:
> On Wed, Aug 16, 2006 at 08:02:02PM +0200, Prakash Punnoor wrote:
> > Am Mittwoch 16 August 2006 19:43 schrieb Pozsar Balazs:
> > 
> > > So, just to make it clear: if you boot without cable plugged in, let
> > > the driver load, and then plug the cable in, do you have link?
> > > For me, it does not have link until I rmmod the module.
> > 
> > Same here.
> 
> The most weird thing is that, when I _rmmod_ the module, the link leds 
> will show a link, _before_ I even re-modprobe it! So somehow the removal 
> (or even an unbind via the sysfs interface) "resets" it.

Hey folks,

Added to my to-do list.  Let me know if you figure out anything else.

-VAL
