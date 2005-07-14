Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261613AbVGNRct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbVGNRct (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 13:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbVGNRch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 13:32:37 -0400
Received: from mailfe08.swip.net ([212.247.154.225]:21890 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262799AbVGNRaU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 13:30:20 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: Kernel Bug Report
From: Alexander Nyberg <alexn@telia.com>
To: vandep01@student.ucr.edu
Cc: linux-kernel@vger.kernel.org, ruschein@infomine.ucr.edu
In-Reply-To: <30a258ac.1bd5021b.81be400@smh.ucr.edu>
References: <30a258ac.1bd5021b.81be400@smh.ucr.edu>
Content-Type: text/plain
Date: Thu, 14 Jul 2005 19:30:11 +0200
Message-Id: <1121362211.2043.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tor 2005-07-14 klockan 10:10 -0700 skrev Paul Vander Griend:
> System:
> Motherboard = Tyan K8WE
> Processor = 2x Opteron 250
> Memory = 8GB ECC Registered
> 
> On all of the recent release candidates except for
> 2.6.13-rc2-git2 the kernel panics while booting. These
> versions include 2.6.13-rc2-git* (* != 2 ) and 2.6.13-rc3.
> 
> I also want to mention that I am using gcc 3.3.5 on debian and
> that during compilation there are 3 messages at the end that
> say an assertion has failed IE (LD: assertion failed).

Those are harmless

> It looks like it panics during a mem_cpy but I know its
> difficult to tell just by the output.
> 
> I get a code: f3 a4 c3 66 66 66 90 66 66 66 90 66 66 66 90 66
> 
> The problem appears very reproducable so I can provide more
> information upon request.

What does the rest of the panic say? There should be text above this
that tells where the panic occured and why. Can you please send that
here?

