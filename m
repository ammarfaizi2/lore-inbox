Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277140AbRJHV0T>; Mon, 8 Oct 2001 17:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277139AbRJHV0J>; Mon, 8 Oct 2001 17:26:09 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31506 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277141AbRJHV0A>; Mon, 8 Oct 2001 17:26:00 -0400
Subject: Re: linux-2.4.10-acX
To: rml@tech9.net (Robert Love)
Date: Mon, 8 Oct 2001 22:32:01 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <1002576203.8568.192.camel@phantasy> from "Robert Love" at Oct 08, 2001 05:23:22 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15qi0H-0001xD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > getting very hard to merge a lot of the fixes like the truncate standards
> > compliance stuff so they may not make Linus tree until 2.5
> 
> What are Linus's complaints about the faster syscall path improvement?

He insisted it wouldnt make it any faster. Of course rdtsc and profiling
counters of locked cycles show otherwise..
