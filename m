Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263575AbTJ0Vbm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 16:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263582AbTJ0Vbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 16:31:42 -0500
Received: from bluebox.CS.Princeton.EDU ([128.112.136.38]:57489 "EHLO
	bluebox.CS.Princeton.EDU") by vger.kernel.org with ESMTP
	id S263575AbTJ0Vbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 16:31:41 -0500
Date: Mon, 27 Oct 2003 16:31:40 -0500 (EST)
From: Yaoping Ruan <yruan@CS.Princeton.EDU>
To: linux-kernel@vger.kernel.org
Subject: /proc/cpuinfo & top
In-Reply-To: <5.1.0.14.2.20031022014409.00bd4aa0@hesiod>
Message-ID: <Pine.LNX.4.58.0310221233040.14330@opus.cs.princeton.edu>
References: <5.1.0.14.2.20031022014409.00bd4aa0@hesiod>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I compiled 2.4.21 kernel with SMP and High-MEM enabled on a dual-CPU box,
but surprised to see there're 4 CPUs in /proc/cpuinfo and top. But
/proc/cpuinfo is correct if SMP is disable during kernel configuration.
Did anybody experience this before?

Many thanks in advance

- Yaoping Ruan
