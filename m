Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264997AbTFLUpy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 16:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264993AbTFLUpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 16:45:54 -0400
Received: from aneto.able.es ([212.97.163.22]:44690 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S265000AbTFLUpw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 16:45:52 -0400
Date: Thu, 12 Jun 2003 22:59:31 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Scott Robert Ladd <coyote@coyotegulch.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SMP question
Message-ID: <20030612205931.GA3796@werewolf.able.es>
References: <MDEHLPKNGKAHNMBLJOLKMEJLDJAA.davids@webmaster.com> <200306112313.30903.artemio@artemio.net> <20030611225401.GE2712@werewolf.able.es> <3EE887FA.90008@coyotegulch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3EE887FA.90008@coyotegulch.com>; from coyote@coyotegulch.com on Thu, Jun 12, 2003 at 16:02:34 +0200
X-Mailer: Balsa 2.0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.12, Scott Robert Ladd wrote:
> J.A. Magallon wrote:
> > In short, for FP intensive tasks, hyperthreading is a big lie...
> > You can't run 2 computations in parallel.
> 
> Yes and no; the benefit of HT depends on the application in question. 
> I've seen everything from a 5% LOSS in performance to a 30% INCREASE in 
> performance, for intensive floating-point code. This is with programs 
> parallelized with OpenMP and Intel's C and Fortran compilers. I'm still 
> analyzing the exact nature of the benefits, but they *do* exist.
> 
> While I much prefer multiple physical CPUs to "virtual" CPUs, HT *does* 
> provide performance improvements for certain applications. To call HT a 
> "big lie" is both provacative and inaccurate.
> 

I told that because non-techical people just think they are buying _two_
processors, but they really pay too much for 1.25 processors, and that
if you fine-tune your code...

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.21-rc8-jam1 (gcc 3.3 (Mandrake Linux 9.2 3.3-1mdk))
