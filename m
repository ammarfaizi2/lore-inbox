Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbTIPPoq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 11:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbTIPPop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 11:44:45 -0400
Received: from pat.uio.no ([129.240.130.16]:46562 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261968AbTIPPoo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 11:44:44 -0400
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: df hangs on nfs automounter in 2.6.0-current
References: <Pine.GSO.4.44.0309161732480.19310-100000@math.ut.ee>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 16 Sep 2003 11:44:40 -0400
In-Reply-To: <Pine.GSO.4.44.0309161732480.19310-100000@math.ut.ee>
Message-ID: <shsznh4d9g7.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Meelis Roos <mroos@linux.ee> writes:

     > Current 2.6.0 (2.6.0-test5+BK as of 16.09) hangs on df when the
     > am_utils automounter is in use. It displays hda* partitions and
     > next by mountpoint list is amd but then df hangs, wchan is
     > rpc_execu*

Please reproduce using ordinary 'mount'...

Cheers,
  Trond
