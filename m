Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282970AbRLDJ2E>; Tue, 4 Dec 2001 04:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282983AbRLDJ15>; Tue, 4 Dec 2001 04:27:57 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:45328 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S282970AbRLDJ1q>; Tue, 4 Dec 2001 04:27:46 -0500
Subject: Re: [Linux-ia64] patch to no longer use ia64's software mmu
To: davidm@hpl.hp.com
Date: Tue, 4 Dec 2001 09:36:33 +0000 (GMT)
Cc: arjanv@redhat.com (Arjan van de Ven), linux-kernel@vger.kernel.org,
        linux-ia64@linuxia64.org, marcelo@conectiva.com.br, davem@redhat.com
In-Reply-To: <15371.62205.231945.798891@napali.hpl.hp.com> from "David Mosberger" at Dec 03, 2001 01:47:41 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16BC09-0001Ql-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Another concern I have is that, fundamentally, I dislike the idea of
> penalizing all IA-64 platforms due to one chipset that is, shall we
> say, "lacking" (i.e., doesn't have an I/O TLB).

Allow me to introduce to you the concept of CONFIG_ options 8) It makes a
lot of sense to have a generic IA64 kernel, and an IA64 designed by people
with a brain kernel.

Alan
