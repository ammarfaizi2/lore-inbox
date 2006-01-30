Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbWA3RDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWA3RDP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 12:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbWA3RDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 12:03:15 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:57493
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S964786AbWA3RDO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 12:03:14 -0500
Subject: Re: 2.6.15-rt16
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: chris <cperkins@OCF.Berkeley.EDU>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SOL.4.63.0601300839050.8546@conquest.OCF.Berkeley.EDU>
References: <Pine.SOL.4.63.0601300839050.8546@conquest.OCF.Berkeley.EDU>
Content-Type: text/plain
Date: Mon, 30 Jan 2006 18:03:12 +0100
Message-Id: <1138640592.12625.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-30 at 08:49 -0800, chris wrote:
> hi,
> i'm trying to use ingo's 2.6.15-rt16 patch on an x86_64 machine but it 
> keeps crashing in kmem_cache_init during bootup. i've tried older 
> 2.6.15-rtX patches and they all crash during startup but vanilla 2.6.15 
> works fine for me. anyone else seen this happen with realtime-preempt 
> patches? here's the message:

Can you please send me your .config file ?

	tglx


