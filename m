Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbTIOPru (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 11:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbTIOPru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 11:47:50 -0400
Received: from pat.uio.no ([129.240.130.16]:7109 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261491AbTIOPrs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 11:47:48 -0400
To: russell@coker.com.au
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops on 2.4.22 when mounting from broken NFS server
References: <200309131938.40177.russell@coker.com.au>
	<200309152247.20462.russell@coker.com.au>
	<shs3ceyjc4k.fsf@charged.uio.no>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 15 Sep 2003 11:47:46 -0400
In-Reply-To: <shs3ceyjc4k.fsf@charged.uio.no>
Message-ID: <shsy8wqhx3x.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Trond Myklebust <trond.myklebust@fys.uio.no> writes:

     > Without a tcpdump, there's no way to know why this dumped. In
     > what way was the NFS server broken, and exactly how do you
     > expect the Linux NFS client to protect you against it?

BTW: that Oops you posted looked very much like a memory corruption
problem. Were you running vanilla 2.4.22 on the client, or was it too
patched?

Cheers,
  Trond
