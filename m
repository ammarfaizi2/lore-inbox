Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbTJPOWP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 10:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262971AbTJPOWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 10:22:15 -0400
Received: from smtphost.cis.strath.ac.uk ([130.159.196.96]:39610 "EHLO
	smtphost.cis.strath.ac.uk") by vger.kernel.org with ESMTP
	id S262927AbTJPOWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 10:22:14 -0400
Date: Thu, 16 Oct 2003 10:22:09 -0400
From: iain d broadfoot <ibroadfo@cis.strath.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: pcmcia working again in -test7!
Message-ID: <20031016142209.GA1163@iain-vaio-fx405>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Editor: Vim http://www.vim.org/
X-Operating-System: Linux/2.6.0-test7 (i686)
X-Uptime: 10:06:58 up 40 min,  3 users,  load average: 0.47, 0.35, 0.95
User-Agent: Mutt/1.5.4i
X-CIS-MailScanner: Found to be clean
X-CIS-MailScanner-SpamCheck: not spam, SpamAssassin (score=-8, required 6,
	BAYES_00 -5.20, USER_AGENT_MUTT -2.80)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My wireless pcmcia card is happy again, for the first time since test3.

for i in `grep E: /usr/local/src/kernel/linux-2.6.0-test7/CREDITS
	|cut -d: -f 2`;do echo "thanks"|mail $i;done

iain
-- 
"If sharing a thing in no way diminishes it, it is not rightly owned if it is
not shared." -- St. Augustine
