Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbULGLg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbULGLg1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 06:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbULGLg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 06:36:27 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:33961 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261786AbULGLgZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 06:36:25 -0500
Date: Tue, 7 Dec 2004 12:36:11 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to measure i386 timer interrupt overhead
In-Reply-To: <200412062209_MC3-1-902F-B102@compuserve.com>
Message-ID: <Pine.LNX.4.53.0412071235130.18630@yvahk01.tjqt.qr>
References: <200412062209_MC3-1-902F-B102@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>If this program actually works, then the SMP timer interrupt on this
>system takes 1200-1420 cycles, with 448 of 945 taking 1200-1219 cycles.
>(All the normal interrupts are bound to CPU 0.)

Did you intend to measure the cycles, ticks(jiffies) or usec overhead?



Jan Engelhardt
-- 
ENOSPC
