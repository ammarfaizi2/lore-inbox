Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263125AbVGaAK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263125AbVGaAK2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 20:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263133AbVGaAK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 20:10:27 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:63946 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263125AbVGaAKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 20:10:18 -0400
Subject: Re: Simple question re: oops
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1122767292.4464.1.camel@mindpipe>
References: <1122767292.4464.1.camel@mindpipe>
Content-Type: text/plain
Date: Sat, 30 Jul 2005 20:10:17 -0400
Message-Id: <1122768617.4464.3.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-07-30 at 19:48 -0400, Lee Revell wrote:
> I have a machine here that oopses reliably when I start X, but the
> interesting stuff scrolls away too fast, and a bunch more Oopses get
> printed ending with "Aieee, killing interrupt handler".
> 
> How do I get the output to stop after the first Oops?
> 

Never mind, /proc/sys/kernel/panic_on_oops should do it.

Lee


