Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261841AbVCLDyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbVCLDyr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 22:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbVCLDyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 22:54:47 -0500
Received: from peabody.ximian.com ([130.57.169.10]:57273 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261842AbVCLDyp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 22:54:45 -0500
Subject: Re: 2.6.11: USB broken on nforce4, ipv6 still broken, centrino
	speedstep even more broken than in 2.6.10
From: Adam Belay <abelay@novell.com>
To: Felix von Leitner <felix-linuxkernel@fefe.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20050311202122.GA13205@fefe.de>
References: <20050311202122.GA13205@fefe.de>
Content-Type: text/plain
Date: Fri, 11 Mar 2005 22:51:57 -0500
Message-Id: <1110599518.12485.275.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-11 at 20:21 +0000, Felix von Leitner wrote:
> Linux is getting less and less usable for me. :-(
> 
> 
> My new nForce 4 mainboard has 10 or so USB 2.0 outlets.  In Windows,
> they all work.  In Linux, two of them work.  Putting my USB stick or
> anything else in one of the others produces nothing in Linux.
> Apparently no IRQ getting through or something?

Could you also include lspci -vv.

Thanks,
Adam


