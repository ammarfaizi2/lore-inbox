Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266265AbUBJSpi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 13:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266267AbUBJSoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 13:44:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:14802 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266175AbUBJSmz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 13:42:55 -0500
Date: Tue, 10 Feb 2004 10:42:50 -0800
From: "David S. Miller" <davem@redhat.com>
To: Martin Diehl <lists@mdiehl.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] dma_sync_to_device
Message-Id: <20040210104250.11e95c87.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0402101815550.2349-100000@notebook.home.mdiehl.de>
References: <Pine.LNX.4.44.0402101815550.2349-100000@notebook.home.mdiehl.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Feb 2004 18:31:40 +0100 (CET)
Martin Diehl <lists@mdiehl.de> wrote:

> last fall we agreed there is a dma call missing to sync streaming out dma 
> mappings before giving the buffer back to the device. I've sent you a 
> patch which you liked IIRC. However, I wasn't repeatedly polling you for 
> actually inclusion due to the 2.6 stabilization period.
> 
> Anyway, I see now other related stuff (like dma_pool patches) getting in
> so I'm wondering whether it might be the right moment now - right after 
> 2.6.3-final I'd suggest. So let me resend and ask for application. I've 
> just retested with 2.6.3-rc2 and verified the old patch still applies 
> cleanly and works as expected.

Believe it or not your work still sits deep in my inbox waiting for my backlog
to work on back to it.

I'll try to get to this again.
