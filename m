Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265974AbTGOHKH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 03:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265976AbTGOHKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 03:10:07 -0400
Received: from [66.212.224.118] ([66.212.224.118]:13326 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S265974AbTGOHKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 03:10:05 -0400
Date: Tue, 15 Jul 2003 03:13:31 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
Cc: Kernel Developer List <linux-kernel@vger.kernel.org>
Subject: Re: e1000 with 82546EB parts on 2.4?
In-Reply-To: <20030715001654.D25443@one-eyed-alien.net>
Message-ID: <Pine.LNX.4.53.0307150312250.32541@montezuma.mastecende.com>
References: <20030715001654.D25443@one-eyed-alien.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jul 2003, Matthew Dharm wrote:

> What I've got is your basic x86 machine with an Intel 82546EB dual-GigE
> controller on a PCI bus.  I load e1000.o, ifconfig, and I'm running.  The
> interface is solid as a rock, AFAICT.  I've left it running for days
> without any problems.
> 
> However, if I ifdown and then ifup the interface, I'm borked.  Based on
> tcpdump from another machine, the interface is definately transmitting
> packets just fine.  But, it never seems to notice any packets on the
> receive side.

Does unloading and reloading the module 'fix' things?

-- 
function.linuxpower.ca
