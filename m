Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbUCDOBA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 09:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbUCDOBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 09:01:00 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:35974 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S261910AbUCDOAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 09:00:54 -0500
Date: Thu, 4 Mar 2004 13:59:32 +0000
From: Dave Jones <davej@redhat.com>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: modules registering as sysctl handlers
Message-ID: <20040304135932.GA6659@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Muli Ben-Yehuda <mulix@mulix.org>,
	viro@parcelfarce.linux.theplanet.co.uk,
	Linux-Kernel <linux-kernel@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>
References: <20040302122909.GG24260@mulix.org> <20040302124106.GQ16357@parcelfarce.linux.theplanet.co.uk> <1078272339.15766.5.camel@bach> <20040303092239.GA31820@mulix.org> <20040303104332.GR16357@parcelfarce.linux.theplanet.co.uk> <20040304103824.GA7206@mulix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040304103824.GA7206@mulix.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2004 at 12:38:25PM +0200, Muli Ben-Yehuda wrote:

 > ./drivers/cpufreq/cpufreq_userspace.ko uses register_sysctl

Obsolete, and will be going away in 2.7
There's a perfectly functional sysfs interface for this stuff now.
 

		Dave
