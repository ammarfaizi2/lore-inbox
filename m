Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268468AbUJJUdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268468AbUJJUdx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 16:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268470AbUJJUdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 16:33:53 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:4688 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S268468AbUJJUdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 16:33:50 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
       openib-general@openib.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Message-Flag: Warning: May contain useful information
References: <20041008202247.GA9653@kroah.com> <528yagn63x.fsf@topspin.com>
	<41673772.9010402@pobox.com> <52zn2wlh8h.fsf@topspin.com>
	<416767BA.1020204@pobox.com> <52k6tzlhqt.fsf@topspin.com>
	<1097435131.29422.7.camel@localhost.localdomain>
From: Roland Dreier <roland@topspin.com>
Date: Sun, 10 Oct 2004 13:33:46 -0700
In-Reply-To: <1097435131.29422.7.camel@localhost.localdomain> (Alan Cox's
 message of "Sun, 10 Oct 2004 20:05:32 +0100")
Message-ID: <52brfal3dh.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [openib-general] InfiniBand incompatible with the Linux kernel?
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 10 Oct 2004 20:33:47.0517 (UTC) FILETIME=[71AFEAD0:01C4AF08]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Alan> The big question seems to be about the standard itself. Are
    Alan> the items at issue hardware or software ? We already deal
    Alan> with a lot of devices that have hardware related patent
    Alan> pools and those by themselves don't seem to cause problems.

As far as I know there are no items at issue.  No one has suggested
that there actually are any patents to worry about.  The big complaint
is just that the IBTA member companies haven't made enough promises
about their patents.

The OpenIB subversion repository can be checked out by anyone
interested.  Anyone who wants to can look the code over and look for
something patent encumbered.

Thanks,
  Roland
