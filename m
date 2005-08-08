Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbVHHVBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbVHHVBV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 17:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbVHHVBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 17:01:21 -0400
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:41857 "EHLO
	clueserver.org") by vger.kernel.org with ESMTP id S932223AbVHHVBU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 17:01:20 -0400
Date: Mon, 8 Aug 2005 12:55:04 -0700 (PDT)
From: alan <alan@clueserver.org>
X-X-Sender: alan@www.fnordora.org
To: Lee Revell <rlrevell@joe-job.com>
Cc: abonilla@linuxwireless.org, "'Andreas Steinmetz'" <ast@domdv.de>,
       "'Arjan van de Ven'" <arjan@infradead.org>,
       "'Denis Vlasenko'" <vda@ilport.com.ua>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: Wireless support
In-Reply-To: <1123528018.15269.44.camel@mindpipe>
Message-ID: <Pine.LNX.4.44.0508081250490.11172-100000@www.fnordora.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Aug 2005, Lee Revell wrote:

> On Mon, 2005-08-08 at 12:56 -0600, Alejandro Bonilla wrote:
> > Again, the point is that ndiswrapper is a great project, but people
> > uses it for the leftovers! We *shouldn't* buy leftovers or from Manuf
> > that don't care about Linux.
> 
> If you are always speccing out new systems then of course, but in the
> real world I have some customers who need to dual boot and ideally it
> would work on their existing hardware.  Linux is a harder sell if people
> need to replace a lot of their gear.

Also remember that some people do not have a choice.  They are stuck with 
the crappy laptops that purchasing gets.

I am in a similar bind.  I was planning on swapping out the minipci 
Broadcom card.  Only after I purchaced the laptop did I find out that the 
bios was set to only recognise that wireless chipset.  (Other than that it 
is an incredible AMD 64 laptop.)

The biggest problem with ndisdriver is that it does not work with 64 bit 
kernels (last I checked) and it does not work with Kismet/AirSnort/etc.

-- 
Q: Why do programmers confuse Halloween and Christmas?
A: Because OCT 31 == DEC 25.

