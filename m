Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbVAMVDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbVAMVDJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 16:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbVAMVAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 16:00:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:24547 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261519AbVAMUzJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 15:55:09 -0500
Date: Thu, 13 Jan 2005 12:55:03 -0800
From: Chris Wright <chrisw@osdl.org>
To: akpm@osdl.org, torvalds@osdl.org, alan@lxorguk.ukuu.org.uk,
       marcelo.tosatti@cyclades.com
Cc: linux-kernel@vger.kernel.org
Subject: security contact draft
Message-ID: <20050113125503.C469@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To keep the conversation concrete, here's a pretty rough stab at
documenting the policy.

 Linux kernel developers take security very seriously.  As such, we'd
 like to know when a security bug is found so that it can be fixed and
 disclosed as quickly as possible.

 1) Contact

 The Linux kernel security contact is $CONTACTADDR.  This is a private
 list of security officers who will help verify the bug report and develop
 and release a fix.  It is possible that the security officers will bring
 in extra help from area maintainers to understand and fix the security
 vulnerability.

 It is preferred that mail sent to the security contact is encrypted
 with $PUBKEY.

 As it is with any bug, the more information provided the easier it
 will be to diagnose and fix.  Please review the procedure outlined in
 REPORTING-BUGS if you are unclear about what information is helpful.
 Any exploit code is very helpful and will not be released without
 consent from the reporter unless it's already been made public.

 2) Disclosure

 The goal of the kernel security contact is to work with the bug submitter
 to bug resolution as well as disclosure.  We prefer to fully disclose
 the bug as soon as possible.  It is reasonable to delay disclosure when
 the bug or the fix is not yet fully understood, the solution is not
 well-tested or for vendor coordination.  However, we expect these delays
 to be short, measurable in days, not weeks or months.  As a basic default
 policy, we expect report to disclosure to be on the order of $NUMDAYS.

