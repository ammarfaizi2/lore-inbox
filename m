Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270713AbTGNRDC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 13:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270698AbTGNRBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 13:01:04 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:39929 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S270713AbTGNRA2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 13:00:28 -0400
Subject: Re: 2.5 'what to expect'
From: Robert Love <rml@tech9.net>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030712003856.GB2904@ip68-4-255-84.oc.oc.cox.net>
References: <20030711140219.GB16433@suse.de>
	 <1057933578.20636.17.camel@dhcp22.swansea.linux.org.uk>
	 <1057944829.6808.5.camel@localhost>
	 <20030712003856.GB2904@ip68-4-255-84.oc.oc.cox.net>
Content-Type: text/plain
Message-Id: <1058203137.21207.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 14 Jul 2003 10:18:57 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-07-11 at 17:38, Barry K. Nathan wrote:

> That's not the 2.5 problem. This one also happens with Red Hat's own
> 2.4 vendor kernels for Red Hat 9, and according to RPM's maintainer
> it's a "harmless" message.

As Jeff said, the other Jeff says there are still problems.

And setting LD_ASSUME_KERNEL=2.2.5 before running rpm prevents the
errors. So I am not so sure..

	Robert Love


