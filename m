Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286322AbSCOItK>; Fri, 15 Mar 2002 03:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286343AbSCOItB>; Fri, 15 Mar 2002 03:49:01 -0500
Received: from dsl-213-023-038-002.arcor-ip.net ([213.23.38.2]:42415 "EHLO
	starship") by vger.kernel.org with ESMTP id <S286322AbSCOIsr>;
	Fri, 15 Mar 2002 03:48:47 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, ian@ianduggan.net (Ian Duggan)
Subject: Re: 2.4.18 Preempt Freezeups
Date: Fri, 15 Mar 2002 09:43:32 +0100
X-Mailer: KMail [version 1.3.2]
Cc: rml@tech9.net (Robert Love), linux-kernel@vger.kernel.org (linux kernel)
In-Reply-To: <E16lhBg-0002Yc-00@the-village.bc.nu>
In-Reply-To: <E16lhBg-0002Yc-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16lnJE-0000VK-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 15, 2002 03:11 am, Alan Cox wrote:
> > Stock 2.4.18+preempt+mki-adapter+win4lin
> > 	- Very frequent, and also repeatable every time I
> > 		try to start win4lin.
> 
> pre-empt is almost certainly going to break things like win4lin

Or rather, a binary thing like win4lin may break pre-empt, putting
further gentle pressure on the vendor to 'go open'.  You could look
at that as a good thing.

I suppose Netraverse will fix it up and life will go on.

-- 
Daniel
