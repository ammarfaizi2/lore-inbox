Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262835AbTIQUAP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 16:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbTIQUAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 16:00:09 -0400
Received: from mikonos.cyclades.com.br ([200.230.227.67]:11784 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id S262752AbTIQUAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 16:00:03 -0400
Date: Wed, 17 Sep 2003 17:00:26 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
X-X-Sender: marcelo@logos.cnet
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, <linux-ia64@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4 force_successful_syscall()
In-Reply-To: <200309101626.48541.bjorn.helgaas@hp.com>
Message-ID: <Pine.LNX.4.44.0309171659510.3994-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Sep 2003, Bjorn Helgaas wrote:

> Here's a 2.4 backport of this change to 2.5:
> 
>     http://linux.bkbits.net:8080/linux-2.5/cset@1.1046.238.7?nav=index.html
> 
> Alpha, ppc, and sparc64 define force_successful_syscall_return() in 2.5,
> but since it's not obvious to me how to do it correctly in 2.4, I left
> them unchanged.

Whats the reasoning behing this patch?


