Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162105AbWKPAYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162105AbWKPAYx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 19:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162107AbWKPAYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 19:24:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:36298 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1162105AbWKPAYx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 19:24:53 -0500
Date: Wed, 15 Nov 2006 16:18:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: eranian@hpl.hp.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 add Intel PEBS and BTS cpufeature bits and
 detection
Message-Id: <20061115161827.f0596a78.akpm@osdl.org>
In-Reply-To: <20061115213241.GC17238@frankl.hpl.hp.com>
References: <20061115213241.GC17238@frankl.hpl.hp.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2006 13:32:41 -0800
Stephane Eranian <eranian@hpl.hp.com> wrote:

> Here is a small patch that adds two cpufeature bits to represent
> Intel's Precise-Event-Based Sampling (PEBS) and Branch Trace Store
> (BTS) features. Those features can be found on Intel P4 and Core 2 
> processors among others and can be used by perfmon.
> 

Andi has already merged a different version of this.  If it needs
updating, please review his tree (most recent -mm will suit) and
send any needed updates.
