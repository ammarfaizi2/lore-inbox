Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbVGXWtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbVGXWtL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 18:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbVGXWtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 18:49:11 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:32437 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261498AbVGXWtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 18:49:10 -0400
Subject: Re: kernel 2.6 speed
From: Lee Revell <rlrevell@joe-job.com>
To: Florin Malita <fmalita@gmail.com>
Cc: Ciprian <cipicip@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <f89941150507241403234949be@mail.gmail.com>
References: <20050724191211.48495.qmail@web53608.mail.yahoo.com>
	 <f89941150507241403234949be@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 24 Jul 2005 18:49:05 -0400
Message-Id: <1122245346.27064.4.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-07-24 at 17:03 -0400, Florin Malita wrote:
> the x86 timer interrupt
> frequency has increased from 100Hz to 1KHz (it's about to be lowered
> to 250Hz)

This is by no means a done deal.  So far no one has posted ANY evidence
that dropping HZ to 250 helps (except one result on a atypically large
system), and there's plenty of evidence that it doesn't.

Lee

