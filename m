Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270066AbTHSKdH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 06:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270200AbTHSKdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 06:33:07 -0400
Received: from smtp2.libero.it ([193.70.192.52]:31699 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id S270066AbTHSKdF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 06:33:05 -0400
Subject: Re: 2.6.0-test3-mm3
From: Flameeyes <daps_mls@libero.it>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
In-Reply-To: <20030819032350.55339908.akpm@osdl.org>
References: <20030819013834.1fa487dc.akpm@osdl.org>
	 <1061287775.5995.7.camel@defiant.flameeyes>
	 <20030819032350.55339908.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1061289265.5993.11.camel@defiant.flameeyes>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 19 Aug 2003 12:34:26 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-19 at 12:23, Andrew Morton wrote:
> You'll need to enable CONFIG_X86_LOCAL_APIC to work around this.
I can't, if I enable it, my system freezes at boot time (before activate
the framebuffer), disabling framebuffer to see the output, the last
message is "Calibrating APIC timer", also if I pass noapic to the kernel
boot params, the system freezes at the same point.

-- 
Flameeyes <dgp85@users.sf.net>

