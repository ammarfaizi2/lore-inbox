Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265445AbTF1XDG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 19:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265452AbTF1XDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 19:03:05 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:17547
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265445AbTF1XDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 19:03:04 -0400
Subject: Re: bkbits.net is down
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: Larry McVoy <lm@bitmover.com>, Scott McDermott <vaxerdec@frontiernet.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030628221507.GI841@gallifrey>
References: <1056732854.3172.56.camel@dhcp22.swansea.linux.org.uk>
	 <20030627235150.GA21243@work.bitmover.com>
	 <20030627165519.A1887@beaverton.ibm.com>
	 <20030628001625.GC18676@work.bitmover.com>
	 <20030627205140.F29149@newbox.localdomain>
	 <20030628031920.GF18676@work.bitmover.com>
	 <1056827655.6295.22.camel@dhcp22.swansea.linux.org.uk>
	 <20030628191847.GB8158@work.bitmover.com> <20030628193857.GH841@gallifrey>
	 <1056832290.6289.44.camel@dhcp22.swansea.linux.org.uk>
	 <20030628221507.GI841@gallifrey>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056842035.6779.13.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 Jun 2003 00:13:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-06-28 at 23:15, Dr. David Alan Gilbert wrote:
> Hmm - why should it suck so badly? Shouldn't USB 2 (yes I mean the
> 480Mbps) manage 40MByte/s+ ?

I don't think you get the full 480Mbit/sec on a single device.
5Mbyte/sec is a bit low but that may be some of the remaining work on
the USB EHCI drivers. I've not tried 2.5.x which may be way better here.


