Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261891AbUDYGxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbUDYGxK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 02:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbUDYGxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 02:53:10 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:14467 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261891AbUDYGxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 02:53:07 -0400
Date: Sat, 24 Apr 2004 13:07:30 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Alexey Mahotkin <alexm@w-m.ru>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: flooded by "CPU#0: Running in modulated clock mode"
Message-ID: <20040424110730.GB2595@openzaurus.ucw.cz>
References: <8765btmd9n.fsf@dim.w-m.ru> <Pine.LNX.4.58.0404211355220.2250@montezuma.fsmlabs.com> <87y8opkxyo.fsf@dim.w-m.ru> <Pine.LNX.4.58.0404211411390.2250@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0404211411390.2250@montezuma.fsmlabs.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> If i recall correctly it's hardware set, i'm not sure if BIOSes can modify
> that these days. One thing you may want to note is that in the modulated
> state the processor doesn't process interrupts and runs at a 50% clock

No interrupts? That would mean almost dead machine.
Are you sure?
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

