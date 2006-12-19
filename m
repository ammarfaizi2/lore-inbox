Return-Path: <linux-kernel-owner+w=401wt.eu-S1754791AbWLSHAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754791AbWLSHAS (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 02:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754798AbWLSHAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 02:00:18 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:50016 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754791AbWLSHAR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 02:00:17 -0500
X-Originating-Ip: 24.148.236.183
Date: Tue, 19 Dec 2006 01:56:04 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: linus' git repo down?
Message-ID: <Pine.LNX.4.64.0612190154130.15178@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-14.754, required 5, ALL_TRUSTED -1.80, BAYES_00 -15.00,
	RCVD_IN_SORBS_DUL 2.05)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  for the last couple of days, i've been unable to pull from linus'
2.6 repository.  i consistently get:

$ git pull
fatal: unexpected EOF
Fetch failure: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
No changes.

even after several retries.  i can clone it from scratch, i just can't
update from it.  thoughts?

rday
