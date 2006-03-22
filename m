Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWCVJbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWCVJbT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 04:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWCVJbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 04:31:19 -0500
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:23244 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S1751161AbWCVJbS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 04:31:18 -0500
In-Reply-To: <1143016080.2955.7.camel@laptopd505.fenrus.org>
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063744.407582000@sorel.sous-sol.org> <1143016080.2955.7.camel@laptopd505.fenrus.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0ffa39bba1c9a708536286f4bb80d605@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: virtualization@lists.osdl.org, Ian Pratt <ian.pratt@xensource.com>,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 04/35] Hypervisor interface header files.
Date: Wed, 22 Mar 2006 09:31:37 +0000
To: Arjan van de Ven <arjan@infradead.org>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 22 Mar 2006, at 08:28, Arjan van de Ven wrote:

>> + * This file may be distributed separately from the Linux kernel, or
>> + * incorporated into other software packages, subject to the 
>> following license:
>> + *
>
> and what, if any, is the license when distributed with the kernel, as
> you propose? Right now there doesn't seem to be any at all, and thus it
> would be undistributable.

I thought GPLv2 would be implicit. I'll add the short GPL stanza to 
each of the offending source files.

Thanks for your other excellent comments by the way.

  -- Keir

