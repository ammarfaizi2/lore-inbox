Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbVHXKoB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbVHXKoB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 06:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbVHXKoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 06:44:00 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:61672
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1750795AbVHXKoA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 06:44:00 -0400
Subject: Re: [RFC: 2.6 patch] #include <asm/irq.h> in interrupt.h
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Adrian Bunk <bunk@stusta.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050824100857.GH5603@stusta.de>
References: <20050824085750.GG5603@stusta.de>
	 <20050824092250.GA26726@infradead.org>  <20050824100857.GH5603@stusta.de>
Content-Type: text/plain
Organization: linutronix
Date: Wed, 24 Aug 2005 10:44:55 +0000
Message-Id: <1124880295.20120.44.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-24 at 12:08 +0200, Adrian Bunk wrote:

> Looking at 2.6.13-rc6-mm2, the only architectures with own enable_irq() 
> implementations are m68knommu and sparc.

You missed ARM.

tglx


