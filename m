Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbTJXMvZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 08:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262168AbTJXMvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 08:51:25 -0400
Received: from intra.cyclades.com ([64.186.161.6]:47800 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262116AbTJXMvY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 08:51:24 -0400
Date: Fri, 24 Oct 2003 10:47:44 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Helmut Jarausch <jarausch@skynet.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23-pre7 doesn't recognize 2nd processor with Intel E7505
In-Reply-To: <200310231925.h9NJPZnU004358@september.skynet.be>
Message-ID: <Pine.LNX.4.44.0310241046490.1354-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 Oct 2003, Helmut Jarausch wrote:

> Hi,
> 
> 2.4.23-pre7 doesn't recognize the second processor on a supermicro
> board with Intel E7505 dual Xeon. (It runs fine on a dual P3 machine)
> 
> The 2.4.22-AC4 kernel recognizes both (even 4 of hyperthreading is
> enabled)
> 
> Since we are still looking for a remedy to a kernel freeze (here on at
> least two different SMP machines) when using a GL-application with and
> WITHOUT the Nvidia video kernel module, we were hoping that the
> recent fix for a race condition in mmap could help.
> 
> Any hints are appreciated,

Helmut, 

Can you send the config file you are using and the boot messages from both 
kernels? 

Thank you

