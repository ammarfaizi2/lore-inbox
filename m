Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267311AbUGNDSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267311AbUGNDSs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 23:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267312AbUGNDSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 23:18:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18617 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267311AbUGNDSq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 23:18:46 -0400
Message-ID: <40F4A602.2020400@pobox.com>
Date: Tue, 13 Jul 2004 23:18:26 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Domsch <Matt_Domsch@dell.com>
CC: David Balazic <david.balazic@hermes.si>, Dave Jones <davej@redhat.com>,
       Andries Brouwer <aebr@win.tue.nl>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Weird:  30 sec delay during early boot
References: <600B91D5E4B8D211A58C00902724252C035F1D0C@piramida.hermes.si> <20040713221623.GA10480@lists.us.dell.com> <40F463B0.1010706@pobox.com> <20040714023233.GA15328@lists.us.dell.com> <20040714030301.GB15328@lists.us.dell.com>
In-Reply-To: <20040714030301.GB15328@lists.us.dell.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No luck here with the patch.  Still a 30-second delay before booting on 
the VIA-based x86-64 box.

Any other debug/machine info I can give you?

	Jeff



