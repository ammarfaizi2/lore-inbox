Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751361AbVJNJre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbVJNJre (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 05:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbVJNJre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 05:47:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4999 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751361AbVJNJrd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 05:47:33 -0400
Date: Fri, 14 Oct 2005 02:46:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Jean Delvare" <khali@linux-fr.org>
Cc: jesper.juhl@gmail.com, linux-kernel@vger.kernel.org, len.brown@intel.com,
       iss_storagedev@hp.com, jj@ultra.linux.cz,
       B.Zolnierkiewicz@elka.pw.edu.pl, axboe@suse.de, rolandd@cisco.com,
       aris@cathedrallabs.org, benh@kernel.crashing.org, drzeus-wbsd@drzeus.cx,
       carsten@sol.wh-hms.uni-ulm.de, greg@kroah.com,
       dahinds@users.sourceforge.net, vinh.truong@eng.sun.com,
       mcorner@umich.edu, downey@zymeta.com, adaplas@pol.net,
       bgardner@wabtec.com
Subject: Re: [PATCH 09/14] Big kfree NULL check cleanup - misc remaining
 drivers
Message-Id: <20051014024610.2bdbfdec.akpm@osdl.org>
In-Reply-To: <vJmVlab2.1129281869.1524300.khali@localhost>
References: <200510132128.45171.jesper.juhl@gmail.com>
	<vJmVlab2.1129281869.1524300.khali@localhost>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jean Delvare" <khali@linux-fr.org> wrote:
>
> BTW, what's the merge plan? Andrew enqueues the whole stuff, or do you
>  expect each individual maitainer to extract his/her part?

In a few weeks time I'll merge up everything which individual maintainers
haven't taken.  If you're OK with your bit of this patch then you don't need
to do anything.

