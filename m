Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261394AbSJUORI>; Mon, 21 Oct 2002 10:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261395AbSJUORI>; Mon, 21 Oct 2002 10:17:08 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:26548 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261394AbSJUORH>; Mon, 21 Oct 2002 10:17:07 -0400
Subject: Re: benchmarks of O_STREAMING in 2.5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Robert Love <rml@tech9.net>
Cc: akpm@digeo.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1034823201.722.429.camel@phantasy>
References: <1034823201.722.429.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Oct 2002 15:38:52 +0100
Message-Id: <1035211132.27309.131.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-17 at 03:53, Robert Love wrote:
> I gave the O_STREAMING in Andrew's 2.5-mm tree the treatment..
> 
> Short summary: It works.
> 
> The streaming read test in the following benchmarks is simply a read()
> in 64KB byte chunks of an 800MB file.

All you now need to do is make it work with an API thats usable by the
other 99% of real world apps, is extensible and sensible ways and
therefore can be used.

