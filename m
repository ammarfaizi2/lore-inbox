Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267374AbUIFAu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267374AbUIFAu0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 20:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267375AbUIFAu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 20:50:26 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:14967 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267378AbUIFAuO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 20:50:14 -0400
Message-ID: <311601c9040905175023ae280f@mail.gmail.com>
Date: Sun, 5 Sep 2004 18:50:13 -0600
From: Eric Mudama <edmudama@gmail.com>
Reply-To: Eric Mudama <edmudama@gmail.com>
To: Matt Domsch <matt_domsch@dell.com>
Subject: Re: HDD LED doesn't light.
Cc: Adrian Yee <brewt-linux-kernel@brewt.org>,
       Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040831195902.GA3945@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <311601c904082709107a8c8475@mail.gmail.com>
	 <GMail.1093981448.21536945.017857081112@brewt.org>
	 <20040831195902.GA3945@lists.us.dell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Aug 2004 14:59:02 -0500, Matt Domsch <matt_domsch@dell.com> wrote:
> On Tue, Aug 31, 2004 at 12:44:08PM -0700, Adrian Yee wrote:
> > But this doesn't explain why I have two motherboards here where the HDD
> > activity LED does not light up in linux (for SATA drives) but does in
> > windows .  Note that it only starts working in windows *after* the
> > driver has loaded.
> 
> I've heard of implementations of the drive light on SATA where it is
> controlled through a general-purpose I/O pin somewhere else in the
> chipset.  If that's the case, then the Windows driver may well know
> how to drive the GPIO to indicate drive activity for you...

That would be my guess too.

This is all part of the initial hiccups in a brand new interface. 
Within another year or two, everything will stabilize out and work "as
intended" (crosses fingers)

--eric
