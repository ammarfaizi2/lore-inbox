Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261801AbVGaQTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbVGaQTK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 12:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbVGaQTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 12:19:10 -0400
Received: from ore.jhcloos.com ([64.240.156.239]:58125 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S261801AbVGaQTJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 12:19:09 -0400
To: Pavel Machek <pavel@ucw.cz>
Cc: Brian Schau <brian@schau.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Wireless Security Lock driver.
From: James Cloos <cloos@jhcloos.com>
In-Reply-To: <20050731095207.GJ9418@elf.ucw.cz> (Pavel Machek's message of "Sun, 31 Jul 2005 11:52:07 +0200")
References: <42EB940E.5000008@schau.com> <20050730194215.GA9188@elf.ucw.cz>
	<42EBDEA9.60505@schau.com> <20050730203159.GB9418@elf.ucw.cz>
	<m3mzo3jriv.fsf@lugabout.cloos.reno.nv.us>
	<20050731095207.GJ9418@elf.ucw.cz>
X-Hashcash: 1:21:050731:pavel@ucw.cz::8GtQeR4oWQKQpLGb:000003SYt
X-Hashcash: 1:21:050731:brian@schau.com::0kuD1vweNhyIt+bU:006cEu
X-Hashcash: 1:21:050731:linux-kernel@vger.kernel.org::wJgFVpI7qv5xNf1V:0000000000000000000000000000000006r07
Date: Sun, 31 Jul 2005 12:14:01 -0400
Message-ID: <m364urj6ly.fsf@lugabout.cloos.reno.nv.us>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Pavel" == Pavel Machek <pavel@ucw.cz> writes:

>> Would /dev/input/mice not also be affected?

Pavel> Yes, /dev/input/mice == /dev/psaux.

What I get for looking in /dev (c 10 1 vs c 13 63) rather than
/usr/src/linux. :-/

-JimC
