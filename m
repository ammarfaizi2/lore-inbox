Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751521AbWCIUwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbWCIUwn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 15:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbWCIUwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 15:52:42 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:52641 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751439AbWCIUwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 15:52:42 -0500
Subject: Re: State of the Linux PCI and PCI Hotplug Subsystems
	for	2.6.16-rc5
From: Lee Revell <rlrevell@joe-job.com>
To: Ben Collins <bcollins@ubuntu.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Tomasz Torcz <zdzichu@irc.pl>,
       Greg KH <gregkh@suse.de>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net
In-Reply-To: <1141935002.6072.40.camel@grayson>
References: <20060306223545.GA20885@kroah.com>
	 <20060308222652.GR4006@stusta.de> <20060308225029.GA26117@suse.de>
	 <Pine.LNX.4.64.0603081502350.32577@g5.osdl.org>
	 <20060308231851.GA26666@suse.de>
	 <Pine.LNX.4.64.0603081528040.32577@g5.osdl.org>
	 <20060309184010.GA4639@irc.pl>
	 <Pine.LNX.4.64.0603091137180.18022@g5.osdl.org>
	 <1141935002.6072.40.camel@grayson>
Content-Type: text/plain
Date: Thu, 09 Mar 2006 15:52:35 -0500
Message-Id: <1141937556.13319.64.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 15:10 -0500, Ben Collins wrote:
> The difference between our 2.6.15 386 and 686 kernels is actually pretty
> huge. The 386 is M486, and UP, while our 686 kernel is M686, and SMP.
> The SMP is also complicated by our use of the SMP-alternatives patch,
> but I believe I had this user test with this disabled (kernel command
> line option that leaves all the SMP code intact for testing). It didn't
> alter the problem. 

Ubuntu doesn't provide a UP 686 kernel?

Isn't there a performance hit running an SMP kernel on UP?

Lee

