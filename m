Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbTILJiy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 05:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbTILJix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 05:38:53 -0400
Received: from smtphost.cis.strath.ac.uk ([130.159.196.96]:58337 "EHLO
	smtphost.cis.strath.ac.uk") by vger.kernel.org with ESMTP
	id S261423AbTILJiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 05:38:52 -0400
Date: Fri, 12 Sep 2003 10:38:37 +0100
From: iain d broadfoot <ibroadfo@cis.strath.ac.uk>
To: lkml <linux-kernel@vger.kernel.org>
Subject: getting a working CD-drive in 2.6
Message-ID: <20030912093837.GC2921@iain-vaio-fx405>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Editor: Vim http://www.vim.org/
X-Operating-System: Linux/2.6.0-test3 (i686)
X-Uptime: 10:35:22 up  2:42,  4 users,  load average: 0.15, 0.36, 0.51
X-Message-Flag: Outlook viruses can be made to send private documents from your hard drive to any or all recipients from your address book. But it only happens about once a month or so, so it's okay. Just keep on using it.
User-Agent: Mutt/1.5.4i
X-CIS-MailScanner: Found to be clean
X-CIS-MailScanner-SpamCheck: not spam, SpamAssassin (score=-8.2, required 5,
	BAYES_01 -5.40, USER_AGENT_MUTT -2.80)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Since starting using 2.6, I've been unable to use my cd-rw/dvd
	drive at all.

	It won't read, and it certainly won't write.

	Attaching my .config for you perusal - what have i done wrong?

	ide-scsi is disabled.

	cheers,

	iain

-- 
"If sharing a thing in no way diminishes it, it is not rightly owned if it is
not shared." -- St. Augustine
