Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032215AbWLGNjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032215AbWLGNjj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 08:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032217AbWLGNjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 08:39:39 -0500
Received: from mx1.redhat.com ([66.187.233.31]:57581 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032216AbWLGNjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 08:39:39 -0500
Subject: Re: [PATCH 2.6.19] i386/io_apic: Fix a typo in an IRQ handler name
From: Ingo Molnar <mingo@redhat.com>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64N.0612061151010.29000@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0612061151010.29000@blysk.ds.pg.gda.pl>
Content-Type: text/plain
Date: Thu, 07 Dec 2006 14:38:41 +0100
Message-Id: <1165498721.23481.9.camel@earth>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-06 at 11:56 +0000, Maciej W. Rozycki wrote:
>  The "fasteoi" IRQ handler is named "fasteio" incorrectly.  This is a
> fix.
> 
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> ---
>  It should be obvious.
> 
>  Please apply. 

ouch ... -stable stuff too i guess.

Acked-by: Ingo Molnar <mingo@redhat.com>

	Ingo

