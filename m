Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265081AbUBOQel (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 11:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265100AbUBOQel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 11:34:41 -0500
Received: from topaz.cx ([66.220.6.227]:5822 "EHLO mail.topaz.cx")
	by vger.kernel.org with ESMTP id S265081AbUBOQek (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 11:34:40 -0500
Date: Sun, 15 Feb 2004 11:34:38 -0500
From: Chip Salzenberg <chip@pobox.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.3-rc3 - IDE DMA errors on Thinkpad A30
Message-ID: <20040215163438.GC3789@perlsupport.com>
References: <E1AsO6X-0003hW-1u@tytlal> <200402151658.57710.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402151658.57710.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Bartlomiej Zolnierkiewicz:
> Please send dmesg command output and your config kernel config
> if you want anybody to look at IDE problems...

OK, I've entered all the info in Bugzilla:

  http://bugzilla.kernel.org/show_bug.cgi?id=2110

I've also included the SMART error dumps ("smartctl -a").  There are
no media problems, if I'm reading it right; whatever else is broken,
the IDE DMA errors seem to be unrelated to actual bad sectors.
-- 
Chip Salzenberg               - a.k.a. -               <chip@pobox.com>
"I wanted to play hopscotch with the impenetrable mystery of existence,
    but he stepped in a wormhole and had to go in early."  // MST3K
