Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130950AbRCFFqH>; Tue, 6 Mar 2001 00:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130952AbRCFFp6>; Tue, 6 Mar 2001 00:45:58 -0500
Received: from [199.183.24.200] ([199.183.24.200]:28489 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S130950AbRCFFpy>; Tue, 6 Mar 2001 00:45:54 -0500
Date: Tue, 6 Mar 2001 00:44:54 -0500
From: Peter Zaitcev <zaitcev@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: Russell King <rmk@arm.linux.org.uk>, David Brownell <david-b@pacbell.net>,
        Manfred Spraul <manfred@colorfullife.com>, zaitcev@redhat.com,
        linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: SLAB vs. pci_alloc_xxx in usb-uhci patch
Message-ID: <20010306004454.A12846@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: "David S. Miller" <davem@redhat.com>
> Date: Mon, 5 Mar 2001 20:53:21 -0800 (PST)

>[...]
> Gerard Roudier wrote for the sym53c8xx driver the exact thing
> UHCI/OHCI need for this.

Thanks for the hint.

***

Anyways, is this the end of the discussion regarding my patch?
If it goes in, then fine. If not, fine too... Just
let me know so that I can close the bug properly.
Manfred said plainly "usb-uhci is broken", Alan kinda
manuevered around my small problem, Dave Brownell looks
unconvinced. So?

-- Pete
