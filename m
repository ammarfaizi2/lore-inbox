Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbTHZWgg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 18:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262905AbTHZWew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 18:34:52 -0400
Received: from smtphost.cis.strath.ac.uk ([130.159.196.96]:21396 "EHLO
	smtphost.cis.strath.ac.uk") by vger.kernel.org with ESMTP
	id S263031AbTHZWeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 18:34:13 -0400
Date: Tue, 26 Aug 2003 23:34:05 +0100
From: iain d broadfoot <ibroadfo@cis.strath.ac.uk>
To: kernel <linux-kernel@vger.kernel.org>
Subject: Same problem with pcmcia in 2.4.22 as in 2.6.0-test4
Message-ID: <20030826223405.GA2746@iain-vaio-fx405>
Mail-Followup-To: kernel <linux-kernel@vger.kernel.org>
References: <1061936739.10642.6.camel@garaged.fis.unam.mx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030823112446.GA3341@iain-vaio-fx405>
X-Editor: Vim http://www.vim.org/
X-Operating-System: Linux/2.6.0-test3 (i686)
X-Uptime: 23:29:15 up  2:07,  4 users,  load average: 0.49, 1.02, 1.17
X-Message-Flag: Outlook viruses can be made to send private documents from your hard drive to any or all recipients from your address book. But it only happens about once a month or so, so it's okay. Just keep on using it.
User-Agent: Mutt/1.5.4i
X-CIS-MailScanner: Found to be clean
X-CIS-MailScanner-SpamCheck: not spam, SpamAssassin (score=-8.4, required 5,
	BAYES_00 -5.20, IN_REP_TO -0.37, REFERENCES -0.00,
	USER_AGENT_MUTT -2.80)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

	I'm currently back in -test3, since it's the most recent version
	to give me working pcmcia.

	orinoco_cs: RequestIRQ: Resource in use

	is what gets printed on insertion, both in 2.4.22 and -test4.

	Does anyone have any thoughts on what I might have
	mis-configured?

	cheers,

	iain

-- 
"If sharing a thing in no way diminishes it, it is not rightly owned if it is
not shared." -- St. Augustine

"As for compromises: no. Free or fuck off." -- Andrew Suffield, on debian-legal
