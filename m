Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261676AbSJCPfT>; Thu, 3 Oct 2002 11:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261741AbSJCPfT>; Thu, 3 Oct 2002 11:35:19 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:16369 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261676AbSJCPfS>; Thu, 3 Oct 2002 11:35:18 -0400
Subject: Re: Linux 2.5.40-ac1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: "David S. Miller" <davem@redhat.com>, alan@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3D9C5FAE.60008@colorfullife.com>
References: <3D9C5827.70703@colorfullife.com>
	<20021003.075034.12648168.davem@redhat.com> 
	<3D9C5FAE.60008@colorfullife.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Oct 2002 16:48:25 +0100
Message-Id: <1033660105.28814.11.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-03 at 16:18, Manfred Spraul wrote:
> There should bit nonatomic bit ops for every byte width.
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=99167415926343&w=2
> 
> I even sent you the patch proposal, but never got a reply.
> 
> Patch again attached, but untested.

What about reverse endianness ?
