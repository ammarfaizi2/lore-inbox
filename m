Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266270AbUA3BIF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 20:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266283AbUA3BIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 20:08:05 -0500
Received: from ns.suse.de ([195.135.220.2]:40322 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266270AbUA3BHx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 20:07:53 -0500
Date: Fri, 30 Jan 2004 02:07:50 +0100
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: yoshfuji@linux-ipv6.org, kas@informatics.muni.cz,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Patch: IPv6/AMD64: bug in net/ipv6/ndisc.c
Message-Id: <20040130020750.16e7d1b3.ak@suse.de>
In-Reply-To: <20040129165645.4dde4ffc.davem@redhat.com>
References: <20040129221538.J24747@fi.muni.cz>
	<20040130.083743.20740540.yoshfuji@linux-ipv6.org>
	<20040129153953.3dd2cd23.davem@redhat.com>
	<20040130014031.31ec050f.ak@suse.de>
	<20040129165645.4dde4ffc.davem@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jan 2004 16:56:45 -0800
"David S. Miller" <davem@redhat.com> wrote:

> On Fri, 30 Jan 2004 01:40:31 +0100
> Andi Kleen <ak@suse.de> wrote:
> 
> > Fine by me. I've been ignoring it forever. But don't you see it on sparc64 too?
> 
> Nope, for some reason gcc-3.2.3 on my systems is missing it.

gcc 3.3 is printing it.

-Andi
