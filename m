Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282968AbRLVXTG>; Sat, 22 Dec 2001 18:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282969AbRLVXSp>; Sat, 22 Dec 2001 18:18:45 -0500
Received: from jalon.able.es ([212.97.163.2]:8637 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S282968AbRLVXSi>;
	Sat, 22 Dec 2001 18:18:38 -0500
Date: Sun, 23 Dec 2001 00:20:38 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] irqrate-2.4.17-A0
Message-ID: <20011223002038.E6735@werewolf.able.es>
In-Reply-To: <Pine.LNX.4.33.0112221227540.4953-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.33.0112221227540.4953-100000@localhost.localdomain>; from mingo@elte.hu on Sat, Dec 22, 2001 at 12:33:33 +0100
X-Mailer: Balsa 1.3.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20011222 Ingo Molnar wrote:
>
>i've uploaded the latest, 2.4.17-A0 IRQ-rate-limiting patch to:
>
>        http://redhat.com/~mingo/irqrate-patches/
>
>this is just a straightforward port to 2.4.17. The patch, while it adds
>the dynamic hard-IRQ-limiting feature and fixes softirq performance, it
>also removes more lines of code than it adds.
>
>comments, bug reports and suggestions are welcome,
>

Mmmm, hunks at the end for your m, mb, mo, etc scripts ?

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.17-beo #1 SMP Fri Dec 21 21:39:36 CET 2001 i686
