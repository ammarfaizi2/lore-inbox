Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267921AbUINXTC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267921AbUINXTC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 19:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266304AbUINXS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 19:18:56 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:60382 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S268051AbUINXMF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 19:12:05 -0400
Date: Wed, 15 Sep 2004 00:12:01 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: dri-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       Evan Paul Fletcher <evanpaul@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] DRM: add missing pci_enable_device()
In-Reply-To: <200409140845.59389.bjorn.helgaas@hp.com>
Message-ID: <Pine.LNX.4.58.0409150008130.23838@skynet>
References: <200409131651.05059.bjorn.helgaas@hp.com> <Pine.LNX.4.58.0409140026430.15167@skynet>
 <200409140845.59389.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> OK, I'll assume you understand the issue and will resolve it.  In the
> meantime, users of DRM will have to supply "pci=routeirq".
>

is this -mm only or is it mainline kernel stuff now?

I'll throw an enable in to the bk tree later on....

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

