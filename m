Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261379AbSJCOL0>; Thu, 3 Oct 2002 10:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261400AbSJCOL0>; Thu, 3 Oct 2002 10:11:26 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:34544 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261379AbSJCOL0>; Thu, 3 Oct 2002 10:11:26 -0400
Subject: Re: Dual PPro timer stopping problem
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <14632.1033653828@warthog.cambridge.redhat.com>
References: <14632.1033653828@warthog.cambridge.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Oct 2002 15:24:36 +0100
Message-Id: <1033655076.28007.22.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-03 at 15:03, David Howells wrote:
> 
> Hi,
> 
> I'm seeing a problem that's causing me someone may be able to shed some light
> on.
> 
> I've been running late 2.5.x kernels on a dual PPro box here for testing
> things. After a while (which can be anything from a few minutes to a couple of
> days), the timer interrupts stop happening. Most other interrupt sources (such
> as the network card, but not, apparently, the keyboard) continue to happen
> though. I've tried changing the motherboard and CPU set, but to no avail.

Does this happen with "noapic" ?

