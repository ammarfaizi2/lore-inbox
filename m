Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbTHaMKc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 08:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbTHaMKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 08:10:32 -0400
Received: from smtphost.cis.strath.ac.uk ([130.159.196.96]:65252 "EHLO
	smtphost.cis.strath.ac.uk") by vger.kernel.org with ESMTP
	id S261342AbTHaMKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 08:10:31 -0400
Date: Sun, 31 Aug 2003 13:10:20 +0100
From: iain d broadfoot <ibroadfo@cis.strath.ac.uk>
To: kernel <linux-kernel@vger.kernel.org>
Subject: Re: Same problem with pcmcia in 2.4.22 as in 2.6.0-test4
Message-ID: <20030831121019.GB22771@iain-vaio-fx405>
Mail-Followup-To: kernel <linux-kernel@vger.kernel.org>
References: <1061936739.10642.6.camel@garaged.fis.unam.mx> <20030826223405.GA2746@iain-vaio-fx405>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030826223405.GA2746@iain-vaio-fx405>
X-Editor: Vim http://www.vim.org/
X-Operating-System: Linux/2.6.0-test3 (i686)
X-Uptime: 13:08:32 up  2:44,  4 users,  load average: 1.74, 1.76, 1.79
X-Message-Flag: Outlook viruses can be made to send private documents from your hard drive to any or all recipients from your address book. But it only happens about once a month or so, so it's okay. Just keep on using it.
User-Agent: Mutt/1.5.4i
X-CIS-MailScanner: Found to be clean
X-CIS-MailScanner-SpamCheck: not spam, SpamAssassin (score=-8.4, required 5,
	BAYES_00 -5.20, IN_REP_TO -0.37, REFERENCES -0.00,
	USER_AGENT_MUTT -2.80)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo again,

Just wondering if anyone has any insights into what's going wrong with
my pcmcia in both 2.4.22 and 2.6.0-test4.

orinoco_cs: RequestIRQ: Resource in use

is the error I get on inserting my wireless card.

thanks,

iain

-- 
"If sharing a thing in no way diminishes it, it is not rightly owned if it is
not shared." -- St. Augustine

"As for compromises: no. Free or fuck off." -- Andrew Suffield, on debian-legal
