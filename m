Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266364AbUHWSr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266364AbUHWSr3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 14:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266654AbUHWSqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 14:46:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:24714 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266364AbUHWSeM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:34:12 -0400
Date: Mon, 23 Aug 2004 11:32:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: thor@math.TU-Berlin.DE, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NetMOS 9805 ParPort interface
Message-Id: <20040823113206.7ca77d79.akpm@osdl.org>
In-Reply-To: <20040823125935.GF4569@logos.cnet>
References: <200408051143.NAA23740@cleopatra.math.tu-berlin.de>
	<20040823125935.GF4569@logos.cnet>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
> On Thu, Aug 05, 2004 at 01:43:13PM +0200, Thomas Richter wrote:
> > 
> > Hi folks,
> > 
> > here's a tiny patch against parport/parport_pc.c for kernel 2.4.26.
> > It adds support for the NetMOS 9805 chip, used in several popular
> > parallel port extension cards available here in germany. The patch below
> > has been found working in a beige G3 Mac and a Canon BJC just fine.
> 
> Thomas,
> 
> I just applied this to v2.4 tree.
> 
> However your new ID's haven't made their way through v2.6, I can't 
> find em in 2.6.8.1-mm4.

I was kinda hoping to be sent a patch which compiles successfully.
