Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286171AbRLJGz7>; Mon, 10 Dec 2001 01:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286170AbRLJGzu>; Mon, 10 Dec 2001 01:55:50 -0500
Received: from [195.66.192.167] ([195.66.192.167]:61960 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S286171AbRLJGzg>; Mon, 10 Dec 2001 01:55:36 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fully preemptible kernel
Date: Mon, 10 Dec 2001 08:54:50 -0200
X-Mailer: KMail [version 1.2]
Cc: kpreempt-tech@lists.sourceforge.net
In-Reply-To: <1007930466.11789.2.camel@phantasy>
In-Reply-To: <1007930466.11789.2.camel@phantasy>
MIME-Version: 1.0
Message-Id: <01121008545000.01013@manta>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 December 2001 18:41, Robert Love wrote:
> Updated preempt-kernel patches for 2.4.16 and 2.4.17-pre6 are now
> available at:
>
>  	ftp://ftp.kernel.org/pub/linux/kernel/people/rml/preempt-kernel
>
> patches for various previous kernels are there as well, but not in sync
> with this release.
>
> This patch enables a fully preemptible linux kernel -- userspace
> processes are preemptible by higher priority tasks, even if running in
> kernel space.  Nice gains in response _and_ throughput are observed.
>
> The main change in this release is support for the SH architecture.
> i386 and ARM are also supported.

I reported a problem with preemptible 2.4.13 and Samba server (oops, problems 
with creation of files from win clients).
Is this issue addressed?
--
vda
