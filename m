Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263033AbTCWLnS>; Sun, 23 Mar 2003 06:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263035AbTCWLnS>; Sun, 23 Mar 2003 06:43:18 -0500
Received: from amsfep14-int.chello.nl ([213.46.243.22]:37664 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id <S263033AbTCWLnM>; Sun, 23 Mar 2003 06:43:12 -0500
From: Jos Hulzink <josh@stack.nl>
To: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: 2.5.65: 3C905 driver doesn't work.
Date: Sun, 23 Mar 2003 12:54:12 +0100
User-Agent: KMail/1.5
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200303211618.36485.josh@stack.nl> <20030321182933.E11076-100000@snail.stack.nl> <20030321175356.GC15652@suse.de>
In-Reply-To: <20030321175356.GC15652@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303231254.12767.josh@stack.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 March 2003 18:53, Dave Jones wrote:
> On Fri, Mar 21, 2003 at 06:31:24PM +0100, Jos Hulzink wrote:
>  > > "acpi=off noapic"
>  > > For me, the third one gets it working again on two boxes.
>  > > Without that, packets are sent, but nothing is ever recieved.
>  >
>  > For me, the third option results in a kernel panic very early during
>  > boot
>  >
>  > :( I'm trying to get more info out of it.
>
> Interesting, can you post that panic ?

Located, caused by a magically jumped back Processor setting (P4 code doesn't 
work on P2)

Jos
