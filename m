Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265919AbUBPVvx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 16:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265922AbUBPVvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 16:51:53 -0500
Received: from gate.crashing.org ([63.228.1.57]:22689 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265919AbUBPVvv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 16:51:51 -0500
Subject: Re: kernel-smp on i386, too many arguments to function
	`aty128_find_mem_vbios'
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dave Jones <davej@redhat.com>
Cc: Olaf Hering <olh@suse.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040216161700.GA27470@redhat.com>
References: <20040216092350.GA23211@suse.de>
	 <20040216161700.GA27470@redhat.com>
Content-Type: text/plain
Message-Id: <1076968284.3649.44.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 17 Feb 2004 08:51:25 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Looks straightforward enough...

Yes, sent a patch already. I tested building this function, but not
building the function & the call to it :) (it's __i386__ and I'm on
ppc). Sorry.

Ben.

