Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbTIKPRV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 11:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbTIKPRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 11:17:21 -0400
Received: from pat.uio.no ([129.240.130.16]:6584 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261368AbTIKPRS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 11:17:18 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16224.37361.141709.46654@charged.uio.no>
Date: Thu, 11 Sep 2003 11:17:05 -0400
To: Marco Bertoncin - Sun Microsystems UK - Platform OS
	 Development Engineer <Marco.Bertoncin@sun.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS/MOUNT/sunrpc problem?
In-Reply-To: <200309110932.h8B9Wj126012@brk-mail1.uk.sun.com>
References: <200309110932.h8B9Wj126012@brk-mail1.uk.sun.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


     > This was a 2.4.18 kernel. But I even tried a RH9.0 ... still
     > the problem happens.  Marco

The latest RedHat 9.0 errata kernels are (I believe) 2.4.20
based. That's still more than 9 months old. Please could you check if
the fixes that went into 2.4.22 have any effect on the problem.

Cheers,
  Trond
