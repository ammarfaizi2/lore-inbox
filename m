Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755446AbWKNG4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755446AbWKNG4a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 01:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755447AbWKNG4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 01:56:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51630 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1755446AbWKNG43 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 01:56:29 -0500
Subject: Re: [-mm patch] arch/i386/kernel/apic.c: make a function static
From: Ingo Molnar <mingo@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061113210331.GD22565@stusta.de>
References: <20061108015452.a2bb40d2.akpm@osdl.org>
	 <20061113210331.GD22565@stusta.de>
Content-Type: text/plain
Date: Tue, 14 Nov 2006 07:54:29 +0100
Message-Id: <1163487269.28401.51.camel@earth>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-13 at 22:03 +0100, Adrian Bunk wrote:
> This patch makes the needlessly global local_apic_timer_interrupt() 
> static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de> 

Acked-by: Ingo Molnar <mingo@redhat.com>

	Ingo

