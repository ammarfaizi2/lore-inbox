Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263397AbTHWLv4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 07:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263282AbTHWLvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 07:51:55 -0400
Received: from smtphost.cis.strath.ac.uk ([130.159.196.96]:53208 "EHLO
	smtphost.cis.strath.ac.uk") by vger.kernel.org with ESMTP
	id S263397AbTHWLvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 07:51:46 -0400
Date: Sat, 23 Aug 2003 12:51:20 +0100
From: iain d broadfoot <ibroadfo@cis.strath.ac.uk>
To: dahinds@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0t4 - no pcmcia
Message-ID: <20030823115119.GB3341@iain-vaio-fx405>
Mail-Followup-To: dahinds@users.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20030823112446.GA3341@iain-vaio-fx405> <20030823124050.D25729@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030823124050.D25729@flint.arm.linux.org.uk>
X-Editor: Vim http://www.vim.org/
X-Operating-System: Linux/2.6.0-test3 (i686)
X-Uptime: 12:50:39 up  1:02,  5 users,  load average: 0.92, 0.78, 0.54
X-Message-Flag: Outlook viruses can be made to send private documents from your hard drive to any or all recipients from your address book. But it only happens about once a month or so, so it's okay. Just keep on using it.
User-Agent: Mutt/1.5.4i
X-CIS-MailScanner: Found to be clean
X-CIS-MailScanner-SpamCheck: not spam, SpamAssassin (score=-8.4, required 5,
	BAYES_00 -5.20, IN_REP_TO -0.37, REFERENCES -0.00,
	USER_AGENT_MUTT -2.80)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Russell King (rmk@arm.linux.org.uk) wrote:
> Please check that you have: CONFIG_ISA=y

$ grep CONFIG_ISA linux-2.6.0-test4/.config
CONFIG_ISA=y
# CONFIG_ISAPNP is not set

iain

-- 
"If sharing a thing in no way diminishes it, it is not rightly owned if it is
not shared." -- St. Augustine

"As for compromises: no. Free or fuck off."
	-- Andrew Suffield, on debian-legal
