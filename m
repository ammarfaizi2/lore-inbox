Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288248AbSAMWs7>; Sun, 13 Jan 2002 17:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288255AbSAMWsk>; Sun, 13 Jan 2002 17:48:40 -0500
Received: from dsl081-053-223.sfo1.dsl.speakeasy.net ([64.81.53.223]:52609
	"EHLO starship.berlin") by vger.kernel.org with ESMTP
	id <S288248AbSAMWsh>; Sun, 13 Jan 2002 17:48:37 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, rml@tech9.net (Robert Love)
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Sun, 13 Jan 2002 23:50:21 +0100
X-Mailer: KMail [version 1.3.2]
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), landley@trommello.org (Rob Landley),
        yodaiken@fsmlabs.com, nigel@nrg.org, akpm@zip.com.au (Andrew Morton),
        linux-kernel@vger.kernel.org
In-Reply-To: <E16PZeX-0003ii-00@the-village.bc.nu>
In-Reply-To: <E16PZeX-0003ii-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16PtSM-0000RF-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 13, 2002 02:41 am, Alan Cox wrote:
> [somebody wrote]
> > For a solution to latency concerns, I'd much prefer to lay a framework
> > down that provides a proper solution and then work on fine tuning the
> > kernel to get the desired latency out of it.
> 
> As the low latency patch proves, the framework has always been there, the
> ll patches do the rest

For that matter, the -preempt patch proves that the framework has always - 
i.e., since genesis of SMP - been there for a preemptible kernel.

--
Daniel

