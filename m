Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbTE0Sh5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 14:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262830AbTE0Sh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 14:37:57 -0400
Received: from holomorphy.com ([66.224.33.161]:5609 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262813AbTE0Shz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 14:37:55 -0400
Date: Tue, 27 May 2003 11:50:47 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Jones <davej@codemonkey.org.uk>, Roman Zippel <zippel@linux-m68k.org>,
       John Stoffel <stoffel@lucent.com>,
       DevilKin-LKML <devilkin-lkml@blindguardian.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.70 compile error
Message-ID: <20030527185047.GO8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Jones <davej@codemonkey.org.uk>,
	Roman Zippel <zippel@linux-m68k.org>,
	John Stoffel <stoffel@lucent.com>,
	DevilKin-LKML <devilkin-lkml@blindguardian.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0305261903330.2164-100000@home.transmeta.com> <200305271048.36495.devilkin-lkml@blindguardian.org> <20030527130515.GH8978@holomorphy.com> <200305271729.49047.devilkin-lkml@blindguardian.org> <20030527153619.GJ8978@holomorphy.com> <16083.35048.737099.575241@gargle.gargle.HOWL> <Pine.LNX.4.44.0305272010550.12110-100000@serv> <20030527184016.GA5847@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030527184016.GA5847@suse.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 08:19:39PM +0200, Roman Zippel wrote:
>> This has other advantages too, one can see now which options were newly 
>> added and the individual help texts are accessible.

On Tue, May 27, 2003 at 07:40:16PM +0100, Dave Jones wrote:
> Given that 99% of users will be choosing option 1, it might be a
> good thing to have the remaining options only shown if a
> CONFIG_X86_SUBARCHS=y and have things default to option 1 if =n.

I'll see about this once I get to looking at making CONFIG_X86_NUMAQ
harder to accidentally trip over (unless someone else does it first).


-- wli
