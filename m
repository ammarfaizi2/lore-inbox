Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbTDQRrd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 13:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261848AbTDQRrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 13:47:32 -0400
Received: from havoc.daloft.com ([64.213.145.173]:17555 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261832AbTDQRr3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 13:47:29 -0400
Date: Thu, 17 Apr 2003 13:59:24 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Mark Syms <mark@marksyms.demon.co.uk>
Cc: rl@hellgate.ch, linux-kernel@vger.kernel.org
Subject: Re: Via-Rhine dirve in 2.4.21-pre7
Message-ID: <20030417175924.GE25696@gtf.org>
References: <1049706637.963.6.camel@athlon> <1050602030.988.4.camel@athlon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1050602030.988.4.camel@athlon>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 17, 2003 at 06:53:50PM +0100, Mark Syms wrote:
> The reason I was trying 2.4.21-pre7 is that I have been unable to get
> the network card working on any kernel version if local IO-APIC is
> enabled and I was hoping that the changes you had submitted for the
> 21pre series might help but they did not.

Until further notice, please do not attempt to use Via IOAPIC support.

This has nothing to do with via-rhine, and remains an open issue.

	Jeff



