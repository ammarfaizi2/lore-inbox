Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268472AbUHXWLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268472AbUHXWLx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 18:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268452AbUHXWIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 18:08:41 -0400
Received: from hqemgate00.nvidia.com ([216.228.112.144]:52231 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S268421AbUHXWDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 18:03:22 -0400
Date: Tue, 24 Aug 2004 17:03:07 -0500
From: Terence Ripperda <tripperda@nvidia.com>
To: Roland Dreier <roland@topspin.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Terence Ripperda <tripperda@nvidia.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Michael Geithe <warpy@gmx.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mastergoon@gmail.com
Subject: Re: 2.6.8.1-mm2 (nvidia breakage)
Message-ID: <20040824220307.GO1078@hygelac>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
References: <20040819092654.27bb9adf.akpm@osdl.org> <200408230930.18659.bjorn.helgaas@hp.com> <20040823190131.GC1303@hygelac> <200408240926.42665.bjorn.helgaas@hp.com> <52vff8phf5.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52vff8phf5.fsf@topspin.com>
User-Agent: Mutt/1.4i
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.6.7 
X-OriginalArrivalTime: 24 Aug 2004 22:03:08.0727 (UTC) FILETIME=[23CD6470:01C48A26]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2004 at 10:36:14AM -0700, roland@topspin.com wrote:
> Terence, correct me if I'm wrong, but the change to add
> pci_enable_device() goes in the part of the nvidia driver that has
> source available.  So users can apply this patch themselves even
> without another Nvidia release.

correct.

Thanks,
Terence
