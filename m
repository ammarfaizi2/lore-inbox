Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278879AbRKXQp1>; Sat, 24 Nov 2001 11:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278742AbRKXQpR>; Sat, 24 Nov 2001 11:45:17 -0500
Received: from ns01.netrox.net ([64.118.231.130]:50149 "EHLO smtp01.netrox.net")
	by vger.kernel.org with ESMTP id <S278940AbRKXQpF>;
	Sat, 24 Nov 2001 11:45:05 -0500
Subject: Re: Error: compiling with preempt-kernel-rml-2.4.15-1.patch
From: Robert Love <rml@tech9.net>
To: Steven Walter <srwalter@yahoo.com>
Cc: listmail@majere.epithna.com, linux-kernel@vger.kernel.org
In-Reply-To: <20011123194249.A5258@hapablap.dyn.dhs.org>
In-Reply-To: <Pine.LNX.4.33.0111231906210.3406-100000@majere.epithna.com> 
	<20011123194249.A5258@hapablap.dyn.dhs.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.14.08.58 (Preview Release)
Date: 24 Nov 2001 11:43:45 -0500
Message-Id: <1006620228.1220.2.camel@icbm>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-11-23 at 20:42, Steven Walter wrote:

> Looks like the patch misses a place to has x->has_cpu to task_has_cpu(x)
> Shouldn't be difficult for you to change it.

Indeed.  I put preempt-kernel-rml-2.4.15-2 up at kernel.org:

	ftp://ftp.kernel.org/pub/linux/kernel/people/rml/

which fixes the problem.  I believe kernel.org is now up ...

	Robert Love

