Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261930AbULPNzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbULPNzY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 08:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262660AbULPNzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 08:55:24 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:4738 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261930AbULPNzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 08:55:20 -0500
Subject: Re: arch/xen is a bad idea
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>, Rik van Riel <riel@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       Steven.Hand@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk,
       Keir.Fraser@cl.cam.ac.uk
In-Reply-To: <20041216040136.GA30555@wotan.suse.de>
References: <p73acsg1za1.fsf@bragg.suse.de>
	 <E1CeLLB-0000Sl-00@mta1.cl.cam.ac.uk>
	 <20041215044927.GF27225@wotan.suse.de>
	 <1103155782.3585.29.camel@localhost.localdomain>
	 <20041216040136.GA30555@wotan.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1103201656.3804.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 16 Dec 2004 12:54:17 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-12-16 at 04:01, Andi Kleen wrote:
> That is exactly the part that is wrong currently imho. The arch/xen
> interface is a mess and in its current form unlikely to be maintainable.

It seems maintainable and well documented to me. I just don't see where
your problem is with this. The kernel/hypervisor interface is clear, and
the arch/xen code seems quite sane.


