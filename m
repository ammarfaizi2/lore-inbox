Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbVHRR1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbVHRR1x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 13:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbVHRR1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 13:27:53 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:14281 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932328AbVHRR1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 13:27:51 -0400
Date: Thu, 18 Aug 2005 10:27:45 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Ingo Oeser <ioe-lkml@rameria.de>
cc: Guillermo =?iso-8859-1?q?L=F3pez_Alejos?= <glalejos@gmail.com>,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Environment variables inside the kernel?
In-Reply-To: <200508181812.36086.ioe-lkml@rameria.de>
Message-ID: <Pine.LNX.4.62.0508181022080.26282@schroedinger.engr.sgi.com>
References: <4fec73ca050818084467f04c31@mail.gmail.com>
 <200508181812.36086.ioe-lkml@rameria.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2005, Ingo Oeser wrote:

> Also the Linux kernel is the first "process" ever. 

The first process is init.

> Who should set up it's environment variables?

The kernel command line and the boot loader set up the environment 
variables for the kernel.

> These arguments are no real proof in a mathematical sense,
> but should help you argumenting.

Mathematical proofs are accomplished within a framework of mathematical 
models.

In the postmodern time period and we gave up belief that the mathematical 
models are an accurate representation of reality. We only expect that 
they are sufficiently accurate for the purposes at hand.

