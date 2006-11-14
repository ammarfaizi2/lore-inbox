Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755440AbWKNGzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755440AbWKNGzW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 01:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755446AbWKNGzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 01:55:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7086 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1755440AbWKNGzW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 01:55:22 -0500
Subject: Re: [-mm patch] make arch/i386/kernel/io_apic.c:timer_irq_works()
	static again
From: Ingo Molnar <mingo@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Zachary Amsden <zach@vmware.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061113210349.GF22565@stusta.de>
References: <20061108015452.a2bb40d2.akpm@osdl.org>
	 <20061113210349.GF22565@stusta.de>
Content-Type: text/plain
Date: Tue, 14 Nov 2006 07:53:23 +0100
Message-Id: <1163487203.28401.49.camel@earth>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-13 at 22:03 +0100, Adrian Bunk wrote:
> timer_irq_works() needlessly became global.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de> 

Acked-by: Ingo Molnar <mingo@redhat.com>

	Ingo

