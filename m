Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268535AbUIFThn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268535AbUIFThn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 15:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268504AbUIFThm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 15:37:42 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:6285 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S268565AbUIFThG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 15:37:06 -0400
Date: Mon, 6 Sep 2004 20:36:07 +0100
From: Dave Jones <davej@redhat.com>
To: Steffen Zieger <lkml@steffenspage.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Problems with Centrino CPU
Message-ID: <20040906193607.GA23681@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Steffen Zieger <lkml@steffenspage.de>,
	lkml <linux-kernel@vger.kernel.org>
References: <200409061159.54539.lkml@steffenspage.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409061159.54539.lkml@steffenspage.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06, 2004 at 11:59:52AM +0200, Steffen Zieger wrote:
 > Hello list,
 > 
 > after updating the kernel to 2.6.8.1 I've a problem with my Centrino CPU.
 > The Cache of the CPU is 1024kb, but if I did a cat /proc/cpuinfo I see,
 > that the cache is only 64kb.

Should be fixed in 2.6.9rc1.

		Dave

