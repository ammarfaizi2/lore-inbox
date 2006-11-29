Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934968AbWK2Qhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934968AbWK2Qhh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 11:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935846AbWK2Qhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 11:37:37 -0500
Received: from cantor2.suse.de ([195.135.220.15]:25321 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S934968AbWK2Qhg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 11:37:36 -0500
From: Andi Kleen <ak@suse.de>
To: eranian@hpl.hp.com
Subject: Re: [PATCH] i386 add idle notifier
Date: Wed, 29 Nov 2006 17:37:31 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20061129162540.GL28007@frankl.hpl.hp.com>
In-Reply-To: <20061129162540.GL28007@frankl.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611291737.31827.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 November 2006 17:25, Stephane Eranian wrote:
> Hello,
> 
> Here is a patch that adds an idle notifier to the i386 tree.
> The idle notifier functionalities and implementation are
> identical to the x86_64 idle notifier. We use the idle notifier
> in the context of perfmon.
> 
> The patch is against Andi Kleen's x86_64-2.6.19-rc6-061128-1.bz2
> kernel. It may apply to other kernels but it needs some updates
> to poll_idle() and default_idle() to work correctly.

Added thanks

-Andi
