Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265773AbUINP4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265773AbUINP4Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 11:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269448AbUINP4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 11:56:15 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:60634 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269291AbUINPzw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 11:55:52 -0400
Date: Tue, 14 Sep 2004 08:52:10 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Hanna Linder <hannal@us.ibm.com>, rth@twiddle.net,
       ink@jurassic.park.msu.ru, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [RFT 2.6.9-rc1 alpha sys_alcor.c] [1/2] convert pci_find_device to pci_get_device
Message-ID: <925340000.1095177130@w-hlinder.beaverton.ibm.com>
In-Reply-To: <20040914031705.GX9106@holomorphy.com>
References: <806400000.1095118633@w-hlinder.beaverton.ibm.com> <20040914020257.GF9106@holomorphy.com> <20040914031705.GX9106@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Monday, September 13, 2004 08:17:05 PM -0700 William Lee Irwin III <wli@holomorphy.com> wrote:

> On Mon, Sep 13, 2004 at 07:02:57PM -0700, William Lee Irwin III wrote:
>> I can run it through a compiler, but I won't be able to do meaningful
>> runtime testing on it as I only have tincup and alphapc systems. They
>> look safe at first glance.
> 
> More specifically, if these were merely alpha-specific drivers, I could
> do meaningful testing as they would attempt to be detected this way.
> But this is system-specific initialization executed conditionally on
> the system type, so as the systems I have are not the ones affected by
> these patches, if I were to attempt a runtime test I would merely
> discover that the code was not executed.

Bill,

That is fine if you could just compile it that would satisfy me.

Thanks.

Hanna

