Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263863AbTEFQma (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 12:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263921AbTEFQma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 12:42:30 -0400
Received: from pat.uio.no ([129.240.130.16]:19700 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263863AbTEFQm2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 12:42:28 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16055.59608.512121.756564@charged.uio.no>
Date: Tue, 6 May 2003 18:54:48 +0200
To: Michael Buesch <fsdeveloper@yahoo.de>
Cc: neilb@cse.unsw.edu.au, nfs@lists.sourceforge.net,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Zeev Fisher <Zeev.Fisher@il.marvell.com>
Subject: Re: [NFS] processes stuck in D state
In-Reply-To: <200305061830.25417.fsdeveloper@yahoo.de>
References: <200305061652.13280.fsdeveloper@yahoo.de>
	<200305061742.14032.fsdeveloper@yahoo.de>
	<16055.56630.615496.19679@charged.uio.no>
	<200305061830.25417.fsdeveloper@yahoo.de>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Michael Buesch <fsdeveloper@yahoo.de> writes:

    >> kill -9 all the processes.  kill -9 rpciod.

     > kill -9 doesn't work for me to kill the app.

I didn't say kill the app. I said signal it with -9, then signal
rpciod.

Cheers,
  Trond
