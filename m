Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265889AbUEUPNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265889AbUEUPNt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 11:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265904AbUEUPNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 11:13:48 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:10448 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S265889AbUEUPNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 11:13:46 -0400
Date: Fri, 21 May 2004 11:14:39 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6-mm] Make i386 boot not so chatty
In-Reply-To: <20040520234006.291c3dfa.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0405211113290.2864@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0405210032160.2864@montezuma.fsmlabs.com>
 <20040520234006.291c3dfa.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 May 2004, Andrew Morton wrote:

> Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:
> >
> > This patch silences the default i386 boot by putting a lot of development
> >  related printks under KERN_DEBUG loglevel, allowing the normal chatty mode
> >  to be turned on by using the 'debug' kernel parameter.
>
> I think I like it chatty.  Turning this stuff off by default makes kernel
> developers' lives that little bit harder.
>
> Is the `quiet' option not suitable?

Hey that's just a little too silent ;)

Restarting system.
ip1394: eth2: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
INIT: version 2.85 booting
