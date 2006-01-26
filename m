Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWAZVey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWAZVey (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 16:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbWAZVey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 16:34:54 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:25558
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751213AbWAZVex
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 16:34:53 -0500
Subject: Re: [2.6 patch] kernel/posix-timers.c: remove
	do_posix_clock_notimer_create()
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, george@mvista.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060126095002.GX3590@stusta.de>
References: <20060126095002.GX3590@stusta.de>
Content-Type: text/plain
Date: Thu, 26 Jan 2006 22:36:01 +0100
Message-Id: <1138311361.15232.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-26 at 10:50 +0100, Adrian Bunk wrote:
> This function is neither used nor has any real contents.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Ack
	tglx


