Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288356AbSACW3E>; Thu, 3 Jan 2002 17:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288336AbSACW1H>; Thu, 3 Jan 2002 17:27:07 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:36874 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288350AbSACW0s>; Thu, 3 Jan 2002 17:26:48 -0500
Subject: Re: Who uses hdx=bswap or hdx=swapdata?
To: manfred@colorfullife.com (Manfred Spraul)
Date: Thu, 3 Jan 2002 22:32:39 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C34D6FC.9090207@colorfullife.com> from "Manfred Spraul" at Jan 03, 2002 11:11:08 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16MGPf-0001I3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is the hdx=bswap or hdx=swapdata option actually in use?
> When is it needed?

Certain M68K machines

> The current implementation can cause data corruptions on SMP with PIO 
> transfers:
> 
> Is it possible to remove the option entirely, or should it be fixed?

Show me an SMP Atari ST 8)

