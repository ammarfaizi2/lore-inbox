Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423137AbWJYJDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423137AbWJYJDr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 05:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423143AbWJYJDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 05:03:47 -0400
Received: from aa011msr.fastwebnet.it ([85.18.95.71]:15746 "EHLO
	aa011msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1423137AbWJYJDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 05:03:46 -0400
Message-ID: <019001c6f814$7b0271f0$2b20ff27@flaviopc>
From: "Inter filmati" <interfc@jumpy.it>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel 2.6.17 and 2.6.18  SMP (A64 X2 3800)
Date: Wed, 25 Oct 2006 11:03:47 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
X-Antivirus: avast! (VPS 0643-2, 24/10/2006), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I compiled succesfully these two kernels on my pc, but I can't boot, it
freezes with a kernel panic.
Firs it shows: powernow-k8 powernow-k8: MP systems not supported by PSB BIOS
(only with 2.6.18, not with 2.6.17)
Then 20 30 lines which I can't read as they appear in a few seconds (anyway
I did a video of these lines at http://napex.altervista.org/kernel.zip )
and they end with a : BAD RIP VALUE
Kernel panic: not syncing

I haven't issue with a non smp kernel
I use a 64bit distro
regards

Flavio
www.flapane.com 

