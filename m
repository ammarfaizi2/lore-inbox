Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264829AbUEPVyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264829AbUEPVyw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 17:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264833AbUEPVyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 17:54:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11496 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264829AbUEPVyu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 17:54:50 -0400
Message-ID: <40A7E31B.5020705@pobox.com>
Date: Sun, 16 May 2004 17:54:35 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
CC: Christoph Hellwig <hch@lst.de>, netdev@oss.sgi.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pete Popov <ppopov@mvista.com>
Subject: Re: [PATCH] remove comx drivers from tree
References: <20040507111725.GA11575@lst.de> <40A50292.3070601@pobox.com> <m3sme1cqqg.fsf@defiant.pm.waw.pl>
In-Reply-To: <m3sme1cqqg.fsf@defiant.pm.waw.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa wrote:
> While obviously I don't object (we should list removed things along
> with kernel version somewhere, though)... I could possibly port
> the drivers to my generic HDLC code, if someone sends me the hardware
> in question. Sure, I will never send it back, and it has to have V.35
> or V.24 interface, so I can connect it to something.

Then, *bang*, it's gone :)

We can resurrect if someone appears with hardware, and cares enough to 
bring the driver back to life...  Older kernels are archived on the 
Internet forever, after all :)

	Jeff



