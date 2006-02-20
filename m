Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030277AbWBTPGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030277AbWBTPGH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 10:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030276AbWBTPGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 10:06:07 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:60598 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030277AbWBTPGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 10:06:06 -0500
In-Reply-To: <20060218005532.13620.79663.stgit@localhost.localdomain>
Subject: Re: [PATCH 00/22] [RFC] IBM eHCA InfiniBand adapter driver
To: Roland Dreier <rolandd@cisco.com>
Cc: Heiko J Schick <SCHICKHJ@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, Marcus Eder <MEDER@de.ibm.com>,
       openib-general@openib.org
X-Mailer: Lotus Notes Release 7.0 HF85 November 04, 2005
Message-ID: <OF994D8D1D.24198E91-ONC125711B.00528887-C125711B.0052E575@de.ibm.com>
From: Christoph Raisch <RAISCH@de.ibm.com>
Date: Mon, 20 Feb 2006 16:06:19 +0100
X-MIMETrack: Serialize by Router on D12ML067/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 20/02/2006 16:06:20
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Roland,
as you already stated we really have a problem that we're not able to send
"large" pieces of code to the kernel mailing list.
It's perfectly ok for us to send patches to the openib.org mailing list and
svn.
This is something we still try to resolve with legal.
So thank you Roland for acting as a proxy here...
We have the ok to contribute to any ehca related discussion on kernel
mailing-list and ppc64-mailing list, and are absolutely willing to do so!

Adding a new driver for a complex new hardware isn't the regular linux
develpment case, especially if there's no base code in linux kernel to
patch against...
In our case this patch resulted in 22 postings.
Some people already noticed that there's still quite some road ahead of
us... but we're abolutely willing to work that, and we had to start at some
place.
Some coments will result in modifications to all files.
I guess posting 22 new patch files (diff against NIL) each week is sort of
a DoS attack on the mailing list and we'll end up in peoples spam folders
pretty quickly...
So what's the recomended way to proceed here?


Gruss / Regards . . . Christoph Raisch

christoph raisch, HCAD teamlead

Roland Dreier wrote on 18.02.2006 01:55:32:

> Here's a series of patches that add an InfiniBand adapter driver
> for IBM eHCA hardware.  Please look it over with an eye towards issues
> that need to be addressed before merging this upstream.
>

