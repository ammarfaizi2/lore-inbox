Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267724AbTGHWFG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 18:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267728AbTGHWFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 18:05:06 -0400
Received: from [66.62.77.7] ([66.62.77.7]:14033 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S267724AbTGHWFC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 18:05:02 -0400
Subject: Re: IPSEC
From: Dax Kelson <dax@gurulabs.com>
To: Nico Schottelius <schottelius@wdt.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030708124001.GA2992@schottelius.org>
References: <20030708124001.GA2992@schottelius.org>
Content-Type: text/plain
Message-Id: <1057702779.3325.9.camel@mentor.gurulabs.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 08 Jul 2003 16:19:39 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-07-08 at 06:40, Nico Schottelius wrote:
> Hello!
> 
> I opened an overview about Linux IPSec implementations at
> http://linux.schottelius.org/ipsec/
> I would like to add recent kernel changes in IPSec to the site.
> So it would be very nice if someone could forward
> latest IPSec news to nico-ipsec@schottelius.org..do you think this is possible?

The FreeSWAN/SuperFreeSWAN userland (IKE daemon, etc) has been ported to
work with the 2.5 kernel IPSec code.

Also, the 2.5 kernel IPSec code has been back ported to the 2.4 kernel
by David Miller (more??). It's in the Red Hat Linux rawhide kernel RPMs.

Dax Kelson
Guru Labs

