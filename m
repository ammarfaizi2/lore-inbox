Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270271AbTHSKvb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 06:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270248AbTHSKvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 06:51:31 -0400
Received: from [66.212.224.118] ([66.212.224.118]:38665 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S270271AbTHSKv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 06:51:29 -0400
Date: Tue, 19 Aug 2003 06:51:27 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Flameeyes <daps_mls@libero.it>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test3-mm3
In-Reply-To: <1061289265.5993.11.camel@defiant.flameeyes>
Message-ID: <Pine.LNX.4.53.0308190651010.25386@montezuma.mastecende.com>
References: <20030819013834.1fa487dc.akpm@osdl.org>  <1061287775.5995.7.camel@defiant.flameeyes>
  <20030819032350.55339908.akpm@osdl.org> <1061289265.5993.11.camel@defiant.flameeyes>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Aug 2003, Flameeyes wrote:

> On Tue, 2003-08-19 at 12:23, Andrew Morton wrote:
> > You'll need to enable CONFIG_X86_LOCAL_APIC to work around this.
> I can't, if I enable it, my system freezes at boot time (before activate
> the framebuffer), disabling framebuffer to see the output, the last
> message is "Calibrating APIC timer", also if I pass noapic to the kernel
> boot params, the system freezes at the same point.

Boot with nolapic
