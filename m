Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbTK1RFZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 12:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbTK1RFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 12:05:25 -0500
Received: from pat.uio.no ([129.240.130.16]:34983 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262694AbTK1RFV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 12:05:21 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16327.32843.197191.606592@charged.uio.no>
Date: Fri, 28 Nov 2003 12:05:15 -0500
To: "Shantanu Goel" <Shantanu.Goel@lehman.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: [NFS PATCH] 2.6.0-test10 Invalidate cached inode
 attributes after rename]
In-Reply-To: <3FC77CC3.7090702@lehman.com>
References: <3FC763A5.6030404@lehman.com>
	<shsu14oh27m.fsf@charged.uio.no>
	<3FC77CC3.7090702@lehman.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Shantanu Goel <Shantanu.Goel@lehman.com> writes:

     > BTW, this also affects 2.4 kernels (e.g. RedHat's AS3 kernel)
     > which include your CTO patches that aren't in the upstream
     > kernels yet.

AFAIK Steve Dickson is already aware of the need for this particular
patch for the AS3 kernel. He was one of the people that brought it to
my attention a couple of weeks ago.

Cheers,
  Trond
