Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263596AbTJ0V5Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 16:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263599AbTJ0V5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 16:57:16 -0500
Received: from coral.ocn.ne.jp ([211.6.83.180]:42739 "EHLO
	smtp.coral.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S263596AbTJ0V5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 16:57:13 -0500
Date: Tue, 28 Oct 2003 06:57:10 +0900
From: Bruce Harada <bharada@coral.ocn.ne.jp>
To: Yaoping Ruan <yruan@CS.Princeton.EDU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/cpuinfo & top
Message-Id: <20031028065710.33cf51b9.bharada@coral.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.58.0310221233040.14330@opus.cs.princeton.edu>
References: <5.1.0.14.2.20031022014409.00bd4aa0@hesiod>
	<Pine.LNX.4.58.0310221233040.14330@opus.cs.princeton.edu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Oct 2003 16:31:40 -0500 (EST)
Yaoping Ruan <yruan@CS.Princeton.EDU> wrote:

> Hi,
> 
> I compiled 2.4.21 kernel with SMP and High-MEM enabled on a dual-CPU box,
> but surprised to see there're 4 CPUs in /proc/cpuinfo and top. But
> /proc/cpuinfo is correct if SMP is disable during kernel configuration.
> Did anybody experience this before?

P4s with HT by any chance?
