Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbTEMPGq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 11:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbTEMPGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 11:06:46 -0400
Received: from pat.uio.no ([129.240.130.16]:43982 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261422AbTEMPGp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 11:06:45 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16065.3323.449992.207039@charged.uio.no>
Date: Tue, 13 May 2003 17:19:23 +0200
To: jlnance@unity.ncsu.edu
Cc: linux-kernel@vger.kernel.org, gary.nifong@synopsys.com,
       jlnance@synopsys.com, david.thomas@synopsys.com
Subject: NFS problems with Linux-2.4
In-Reply-To: <20030513145023.GA10383@ncsu.edu>
References: <20030513145023.GA10383@ncsu.edu>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: Please contact postmaster@uio.no for more information
X-UiO-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Could you please try with a newer kernel. The close-to-open cache
consistency fixes are a relatively recent addition to the Linux NFS
client. I dunno if RedHat's 2.4.18 kernel has them.

  2.4.7 certainly does not.

Cheers,
  Trond
