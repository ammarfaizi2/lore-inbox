Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271695AbTHDKQb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 06:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271698AbTHDKQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 06:16:31 -0400
Received: from angband.namesys.com ([212.16.7.85]:29846 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S271695AbTHDKQ3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 06:16:29 -0400
Date: Mon, 4 Aug 2003 14:16:28 +0400
From: Oleg Drokin <green@namesys.com>
To: Martin Pitt <martin@piware.de>
Cc: linux-kernel@vger.kernel.org, vitaly@namesys.com
Subject: Re: PROBLEM: 2.6.0-test1/2 reiserfsck journal replaying hangs
Message-ID: <20030804101628.GD3911@namesys.com>
References: <20030803102321.GA428@donald.balu5> <20030804075420.GB4396@namesys.com> <20030804084306.GB15110@donald.balu5> <20030804091703.GC3911@namesys.com> <20030804101310.GA1187@donald.balu5>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030804101310.GA1187@donald.balu5>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Aug 04, 2003 at 12:13:12PM +0200, Martin Pitt wrote:

> > What was screen looking like at the hang time (can you capture it somehow?),
> That's very difficult, no consoles are active at that time. There are
> no error messages and no messages that don't appear with 2.4.x, apart
> from the warnings about missing module stuff. I can photograph it if
> you want.

Yeah, sure.

> > can you press sysrq-T at the time of a hang and then send us the traces?
> That's even more difficult, it produces several screenfulls of text
> scrolling away very fast. I'd need a serial console for this purpose
> but it will last a while to set this up since I don't have the
> necessary hardware here. I could do it tomorrow.

Well, as I understand, you first press sysrq-T, then ^C, then thing boots and you can
colled sysrq-t output from dmesg or boot logs.
At least I think it should work that way, no?

Bye,
    Oleg
