Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266250AbTBKQRn>; Tue, 11 Feb 2003 11:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266907AbTBKQRn>; Tue, 11 Feb 2003 11:17:43 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:35714 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266250AbTBKQRm>;
	Tue, 11 Feb 2003 11:17:42 -0500
Date: Tue, 11 Feb 2003 16:23:08 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: "Martin J. Bligh" <mbligh@aracnet.com>, torvalds@transmeta.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 339] New: compile failure in drivers/char/watchdog/sc1200wdt.c
Message-ID: <20030211162307.GA20986@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"Martin J. Bligh" <mbligh@aracnet.com>, torvalds@transmeta.com,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <83520000.1044979457@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83520000.1044979457@[10.10.2.4]>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2003 at 08:04:17AM -0800, Martin J. Bligh wrote:
 > http://bugme.osdl.org/show_bug.cgi?id=339
 > 
 >            Summary: compile failure in drivers/char/watchdog/sc1200wdt.c
 >     Kernel Version: 2.5.60-bk1
 >             Status: NEW
 >           Severity: normal
 >              Owner: bugme-janitors@lists.osdl.org
 >          Submitter: john@larvalstage.com

Adam Belay fixed this up recently. I've merged it into my watchdog
repository at bk://linux-dj.bkbits.net/watchdog 
Linus, if you can pull that, that should be the only cset currently
currently pending there.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
