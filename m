Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271721AbTG2OHD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 10:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271807AbTG2OHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 10:07:03 -0400
Received: from pat.uio.no ([129.240.130.16]:59275 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S271721AbTG2OG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 10:06:58 -0400
To: Wakko Warner <wakko@animx.eu.org>
Cc: Balram Adlakha <b_adlakha@softhome.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 NFS file transfer
References: <20030728225947.GA1694@localhost.localdomain>
	<20030729072440.A12426@animx.eu.org>
	<20030729130400.GA4052@localhost.localdomain>
	<20030729094428.B12763@animx.eu.org>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 29 Jul 2003 16:06:46 +0200
In-Reply-To: <20030729094428.B12763@animx.eu.org>
Message-ID: <shsfzkpxw95.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Wakko Warner <wakko@animx.eu.org> writes:

     > On a side note, I wish I could export / to whoever and
     > everything seen on the localsystem under / is exported just
     > like the userspace daemon.

Your homework assignment for tomorrow:

    'man 5 exports'

In particular read up on 'nohide'

Cheers,
  Trond
