Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270508AbTGVNJM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 09:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270764AbTGVNJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 09:09:11 -0400
Received: from genius.impure.org.uk ([195.82.120.210]:44255 "EHLO
	genius.impure.org.uk") by vger.kernel.org with ESMTP
	id S270508AbTGVNJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 09:09:08 -0400
Date: Tue, 22 Jul 2003 14:23:33 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Asfand Yar Qazi <email@asfandyar.cjb.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VIA kt600 chipset supported in Linux?
Message-ID: <20030722132333.GA30567@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Asfand Yar Qazi <email@asfandyar.cjb.net>,
	linux-kernel@vger.kernel.org
References: <3F1CEAFB.2000607@asfandyar.cjb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F1CEAFB.2000607@asfandyar.cjb.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 22, 2003 at 08:42:51AM +0100, Asfand Yar Qazi wrote:
 > As subject really: I don't want any nVidia proprietry rubbish, just nice 
 > clean vanilla kernel configuring and running.
 > 
 > For both 2.4 and 2.6?

AGP at least isn't supported on the KT600. Though it should be
a case of just adding the PCI ID. For AGP x8 you'll need 2.5.

		Dave
