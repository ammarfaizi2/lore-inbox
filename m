Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265408AbTFRUFG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 16:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265410AbTFRUFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 16:05:06 -0400
Received: from ip212-226-133-178.adsl.kpnqwest.fi ([212.226.133.178]:30408
	"EHLO jumper") by vger.kernel.org with ESMTP id S265408AbTFRUFC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 16:05:02 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.71 go boom
References: <87isr7cjra.fsf@jumper.lonesom.pp.fi>
	<20030615191125.I5417@flint.arm.linux.org.uk>
	<87el1vcdrz.fsf@jumper.lonesom.pp.fi>
	<20030615212814.N5417@flint.arm.linux.org.uk>
	<87he6qc3bb.fsf@jumper.lonesom.pp.fi>
	<20030616085403.A5969@flint.arm.linux.org.uk>
	<3EEE173A.8040802@telia.com>
	<20030616212700.J13312@flint.arm.linux.org.uk>
	<3EEEAA9C.5060801@telia.com> <87wufjmahp.fsf@jumper.lonesom.pp.fi>
	<20030618205827.B12994@flint.arm.linux.org.uk>
From: Jaakko Niemi <liiwi@lonesom.pp.fi>
Date: Wed, 18 Jun 2003 23:19:34 +0300
In-Reply-To: <20030618205827.B12994@flint.arm.linux.org.uk> (Russell King's
 message of "Wed, 18 Jun 2003 20:58:27 +0100")
Message-ID: <87smq7m949.fsf@jumper.lonesom.pp.fi>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk@arm.linux.org.uk> writes:

> On Wed, Jun 18, 2003 at 10:49:54PM +0300, Jaakko Niemi wrote:
>> Next, how to get my d-link dwl-650 wlan card up and running. If I insert
>> it, link light on it lights up, and cardctl sees it in socket. However
>> the drivers do not find it, and there is no interface available. This
>> happens at least with 2.5.70 to .72. Anyone got suggestions where to
>> start looking?
>
> Anything in /var/log/messages from cardmgr?

 Nothing whatsoever, only thing I get when unplugging and re-inserting 
 the card is:

 kernel: spurious 8259A interrupt: IRQ7.

                        --j
