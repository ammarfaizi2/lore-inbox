Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265295AbTFRPpS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 11:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265303AbTFRPpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 11:45:18 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:9411 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S265295AbTFRPpO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 11:45:14 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: O(1) scheduler starvation
Date: Thu, 19 Jun 2003 01:59:13 +1000
User-Agent: KMail/1.5.2
Cc: davidm@hpl.hp.com, LKML <linux-kernel@vger.kernel.org>
References: <5.2.0.9.2.20030618113653.0277d780@pop.gmx.net> <5.2.0.9.2.20030618163055.02758e18@pop.gmx.net>
In-Reply-To: <5.2.0.9.2.20030618163055.02758e18@pop.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306190159.13337.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jun 2003 01:54, Mike Galbraith wrote:
> At 04:22 PM 6/18/2003 +0200, Felipe Alfaro Solana wrote:
> >On Wed, 2003-06-18 at 14:04, Mike Galbraith wrote:
> > > At 09:53 AM 6/18/2003 +0200, Felipe Alfaro Solana wrote:
> > > >Hi!
> > > >
> > > >I've been poking around and found the following link on O(1) scheduler
> > > >starvation problems:
> > > >
> > > >http://www.hpl.hp.com/research/linux/kernel/o1-starve.php
<BIG SNIP>

Have you seen this email I just posted to lkml?

[PATCH] 2.5.72 O(1) interactivity bugfix

It may be affecting the scheduler in all sorts of ways.

Con

