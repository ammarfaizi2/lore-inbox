Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264847AbTFLOkK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 10:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264848AbTFLOkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 10:40:10 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:65447 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264847AbTFLOkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 10:40:05 -0400
Date: Thu, 12 Jun 2003 15:53:35 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Anders Karlsson <anders@trudheim.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Pentium M (Centrino) cpufreq device driver (please test me)
Message-ID: <20030612145335.GA14795@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Anders Karlsson <anders@trudheim.com>,
	LKML <linux-kernel@vger.kernel.org>
References: <1055371846.4071.52.camel@localhost.localdomain> <1055406614.2551.6.camel@tor.trudheim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055406614.2551.6.camel@tor.trudheim.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 09:30:14AM +0100, Anders Karlsson wrote:
 > On Wed, 2003-06-11 at 23:50, Jeremy Fitzhardinge wrote:
 > > This is the latest version of my Enhanced SpeedStep driver for cpufreq. 
 > > It supports current Pentium M CPUs.
 > 
 > Can this be rebased against 2.4.21 and be included in 2.4.22-pre please?
 > :-)
 > 
 > If the patch could be applied against 2.4.21-rc, I'd be testing it out.
 > Anything that can make the 'stable' kernel perhaps a bit more stable on
 > the X31 Thinkpad is IMHO a Good Thing.

cpufreq inclusion into 2.4 probably won't happen. There is an older
patch in -ac, but has no-one is updating the 2.4 cpufreq branch any
more, it's lacking quite a lot of fixes that have gone into 2.5.

		Dave

