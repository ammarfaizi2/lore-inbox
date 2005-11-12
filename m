Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbVKLOVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbVKLOVF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 09:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbVKLOVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 09:21:05 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:38612 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932382AbVKLOVD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 09:21:03 -0500
Date: Sat, 12 Nov 2005 15:21:15 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Sven-Thorsten Dietrich <sven@mvista.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.14-rt11 1/3] Fix LPPTEST Kconfig dependancies
Message-ID: <20051112142115.GA24163@elte.hu>
References: <20051111204312.11609.23222.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051111204312.11609.23222.sendpatchset@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Tom Rini <trini@kernel.crashing.org> wrote:

> Since the LPPTEST driver depends on an x86-PC, make the Kconfig choice 
> do so as well.
> 
> Signed-off-by: Tom Rini <trini@kernel.crashing.org>

thanks, applied.

	Ingo
