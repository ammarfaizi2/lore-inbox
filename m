Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264940AbUASXbK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 18:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264941AbUASXbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 18:31:10 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:36001 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264940AbUASXbH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 18:31:07 -0500
In-Reply-To: <20040119230336.GA5008@kroah.com>
References: <200401192200.i0JM0dtb006058@hera.kernel.org> <20040119223230.GA4885@kroah.com> <20040119224953.A7395@infradead.org> <20040119230336.GA5008@kroah.com>
Mime-Version: 1.0 (Apple Message framework v609)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4773719E-4AD7-11D8-B557-000A95A0560C@us.ibm.com>
Content-Transfer-Encoding: 7bit
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       anton@samba.org
From: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: [PATCH] ppc64: VIO support, from Dave Boutcher, Hollis Blanchard and Santiago Leon
Date: Mon, 19 Jan 2004 17:29:08 -0600
To: Greg KH <greg@kroah.com>
X-Mailer: Apple Mail (2.609)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 19, 2004, at 5:03 PM, Greg KH wrote:
> On Mon, Jan 19, 2004 at 10:49:53PM +0000, Christoph Hellwig wrote:
>> I wonder why this code got merged at all.  Half of it could easily be
>> scrapped by using the driver model properly.
>
> Which is another point.  I thought I saw a port of this code to the
> driver model for 2.6 on the ppc mailing list.  Why this old code?

The driver model code is present in the ppc64 tree, pushed Friday. It 
seems this version had been promoted into -mm though, and now into 
mainline.

-- 
Hollis Blanchard
IBM Linux Technology Center

