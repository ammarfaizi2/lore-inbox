Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbTKCOiF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 09:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbTKCOiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 09:38:05 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:17030
	"EHLO x30.random") by vger.kernel.org with ESMTP id S262041AbTKCOiC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 09:38:02 -0500
Date: Mon, 3 Nov 2003 15:36:56 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jan Dittmer <j.dittmer@portrix.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Clock skips (?) with 2.6 and games
Message-ID: <20031103143656.GA6785@x30.random>
References: <3FA62DD4.1020202@portrix.net> <20031103110129.GF1772@x30.random> <3FA63A57.8070606@portrix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FA63A57.8070606@portrix.net>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 03, 2003 at 12:21:59PM +0100, Jan Dittmer wrote:
> I'll give it a try. Is there a way in 2.4-aa to get the two additional
> virtual processors displayed?

No idea why they're not displayed, they should. my HT 2-way xeon shows 4
cpus not 2 (with 2.4 too).
