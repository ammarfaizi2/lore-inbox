Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbTKMGIk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 01:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262330AbTKMGIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 01:08:40 -0500
Received: from pat.uio.no ([129.240.130.16]:63691 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262198AbTKMGIj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 01:08:39 -0500
To: Kyle Rose <krose@krose.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Paging request oops in 2.6.0-test9-bk16
References: <87islohptz.fsf@nausicaa.krose.org>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 13 Nov 2003 01:08:30 -0500
In-Reply-To: <87islohptz.fsf@nausicaa.krose.org>
Message-ID: <shsr80cer6p.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Kyle Rose <krose@krose.org> writes:

     > Got an oops tonight when trying to access an NFS mounted
     > partition through SFS (www.fs.net):

Can it be duplicated against a normal NFS server?

Why is your kernel labelled as "tainted"? Are you loading any modules
other than the ones listed in you .config?

Cheers,
  Trond
