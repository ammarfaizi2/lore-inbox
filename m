Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261573AbSJIK0I>; Wed, 9 Oct 2002 06:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261576AbSJIK0I>; Wed, 9 Oct 2002 06:26:08 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:33118 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S261573AbSJIKZk>; Wed, 9 Oct 2002 06:25:40 -0400
Date: Wed, 9 Oct 2002 12:28:25 +0200
From: Andreas Bergen <andreas.bergen@in-jesus.de>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Dave Spadea <dave@spadea.net>,
       Linux Kernel Development List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel-oops
Message-ID: <20021009102825.GA3816@paulus.in-jesus.de>
References: <20021007145416.GA4695@erde.erde.bergen> <200210071636.48957.dave@spadea.net> <20021008125922.GA3695@erde.erde.bergen> <200210081720.g98HK3p25163@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210081720.g98HK3p25163@Port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2002 at 08:13:35PM -0200, Denis Vlasenko wrote:
> On 8 October 2002 10:59, Andreas Bergen wrote:
> > the problem is, that the machine ran without any problem until I
> > upgraded to kernel version 2.4.18. Originally I used the kernel which
> > was provided by the SuSE 8.0-CDs (2.4.18-4GB). Later I compiled my
> > own kernel, I upgraded to 2.4.19 but nothing helped.
> 
> Okay, you have two versions of kernel, one runs fine, one does not.
> Pick up all the -preN kernels between them and do a binary search.

The 2.4.17 was the standard-kernel without any patches, the 2.4.18 and
2.4.19 as well. Unfortunately I don't have the .config-file for the
2.4.17 anymore, so I can't tell the configuration-difference between
the two. Is there a way to find out the configuration of a kernel?

One thing that came to my mind: Is the problem probably related to the
fact that with 2.4.18/19 my computer won't suspend anymore? It blanks
the screen but doesn't beep and then resumes immediately normally as
the log-file says. When I boot the 2.4.17 everything works as expected.

Thanx a lot in advance
yours
  Andreas Bergen

-- 
Andreas Bergen
E-Mail: andreas.bergen@in-jesus.de
PGP-Key on keyservers.
"Freuet euch in dem Herrn allewege, und abermals sage ich: Freuet euch!" Phi 4,4
