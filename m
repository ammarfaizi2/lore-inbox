Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262286AbTINDoS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 23:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbTINDoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 23:44:17 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:15883 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S262286AbTINDoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 23:44:17 -0400
Subject: Re: PCMCIA in 2.6.0-test5
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Philip Clark <pclark@SLAC.Stanford.EDU>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <x34y8ws47an.fsf@bbrcu5.slac.stanford.edu>
References: <x34y8ws47an.fsf@bbrcu5.slac.stanford.edu>
Content-Type: text/plain
Message-Id: <1063511052.1299.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sun, 14 Sep 2003 05:44:13 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-09-14 at 01:06, Philip Clark wrote:
> Does anyone know of problems with pcmcia in test5? When I moved from
> test4 -> test5 there are now problems and I get "no sockets found"
> messages when I try to start pcmcia. If I do lspci then it detects the
> cardbus bridge no problem. Is anyone out there having similar problems? 

Have you tried with the latest -bk snapshot? I had problems with PCMCIA
on my laptop that have been resolved in -bk3.

