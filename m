Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272739AbTHKPH3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 11:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272741AbTHKPH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 11:07:29 -0400
Received: from pat.uio.no ([129.240.130.16]:2552 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S272739AbTHKPH1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 11:07:27 -0400
To: war <war@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Panic (NFS, 2.4.2[0-1])
References: <Pine.LNX.4.56.0308101710110.10609@p500>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 11 Aug 2003 08:07:15 -0700
In-Reply-To: <Pine.LNX.4.56.0308101710110.10609@p500>
Message-ID: <shsd6fcz10c.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From what I could see, the Oops you posted appeared rather to be
occurring in swapd before propagating to nfs. It would help if you
could decode it through ksymoops first though (see
linux/REPORTING-BUGS).

It would also help if you could try this out on the latest 2.4.22-rc kernel.

Cheers,
  Trond
