Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbTGAJZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 05:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbTGAJZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 05:25:26 -0400
Received: from pat.uio.no ([129.240.130.16]:53667 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261741AbTGAJZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 05:25:24 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16129.22237.385862.74120@charged.uio.no>
Date: Tue, 1 Jul 2003 11:39:41 +0200
To: Matthew Wilcox <willy@debian.org>
Cc: Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: Re: [PATCH 1/4] Optimize NFS open() calls by means of 'intents'...
In-Reply-To: <20030630151426.GG31618@parcelfarce.linux.theplanet.co.uk>
References: <16128.19197.159225.698080@charged.uio.no>
	<20030630151426.GG31618@parcelfarce.linux.theplanet.co.uk>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


     > Can we call the union something descriptive (eg "intent")
     > rather than "u"?

Sure. I'm fine with substutiting 'intent' for 'u' in the final version.

Any other comments/objections/... before I push this on to Linus?

Cheers,
  Trond
