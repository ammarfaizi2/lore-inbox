Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264337AbTKMQKI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 11:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264342AbTKMQKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 11:10:08 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:658
	"EHLO x30.random") by vger.kernel.org with ESMTP id S264337AbTKMQKG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 11:10:06 -0500
Date: Thu, 13 Nov 2003 17:09:33 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andreas Schwab <schwab@suse.de>
Cc: Benoit Poulot-Cazajous <Benoit.Poulot-Cazajous@jaluna.com>,
       Nick Piggin <piggin@cyberone.com.au>,
       Davide Libenzi <davidel@xmailserver.org>, walt <wa1ter@myrealbox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: kernel.bkbits.net off the air
Message-ID: <20031113160933.GL1649@x30.random>
References: <Pine.LNX.4.44.0311102316330.980-100000@bigblue.dev.mdolabs.com> <3FB091C0.9050009@cyberone.com.au> <20031111150417.GF1649@x30.random> <03Nov13.095622cet.122129@mojo.it.advantest.de> <20031113145301.GJ1649@x30.random> <jen0b047ir.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jen0b047ir.fsf@sykes.suse.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 13, 2003 at 04:23:24PM +0100, Andreas Schwab wrote:
> This is not necessary, you only need to recompute the md5sums of changed
> files.

agreed, theoretically I could intercept the changed files through rsync
output, it's more tricky but doable.
