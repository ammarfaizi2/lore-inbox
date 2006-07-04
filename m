Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWGDNEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWGDNEk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 09:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWGDNEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 09:04:39 -0400
Received: from ns.lbox.cz ([62.245.111.135]:20178 "EHLO ns.lbox.cz")
	by vger.kernel.org with ESMTP id S932069AbWGDNEj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 09:04:39 -0400
Subject: watchdog on supermicro h8dce
From: Nikola Ciprich <extmaillist@linuxbox.cz>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 04 Jul 2006 16:04:31 +0300
Message-Id: <1152018271.16496.19.camel@nik-nb>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
X-Antivirus: on proxybox by Kaspersky antivirus, engine 5.0.5, data 192421 records(04-07-2006)
X-Spam-Score: -4.4 (), 4 required
X-Spam-Report: -1.8 ALL_TRUSTED            Passed through trusted hosts only via SMTP
    -2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                                [score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I'm trying to get hardware watchdog running on supermicro H8DCE board.
Unfortunately I wasn't able to find what watchdog is exactly contained
in this board. By trying all modules, I've found that w83627hf_wdt
module seems to work, but after few unexpected reboots I'm not really
sure about it's reliability. I wasn't able to find much documentation
regarding watchdogs support in Linux, does somebody have experience with
this board? Or some tips on how to detect watch dog? Also if somebody
can send me tips on documentation, it could be worth collecting and
maybe adding to Documentation/watchdog kernel directory, or at lease
creating some webpage and adding link about it...
any ideas?
thanks in advance
regards
Nikola


