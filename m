Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129675AbRALEBg>; Thu, 11 Jan 2001 23:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132951AbRALEBZ>; Thu, 11 Jan 2001 23:01:25 -0500
Received: from gherkin.sa.wlk.com ([192.158.254.49]:4868 "HELO
	gherkin.sa.wlk.com") by vger.kernel.org with SMTP
	id <S132942AbRALEBI>; Thu, 11 Jan 2001 23:01:08 -0500
Message-Id: <m14GvOk-0005keC@gherkin.sa.wlk.com>
From: rct@gherkin.sa.wlk.com (Bob_Tracy)
Subject: followup: depmod -a and 2.4.0
To: linux-kernel@vger.kernel.org
Date: Thu, 11 Jan 2001 22:01:06 -0600 (CST)
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dooh!  Please ignore earlier bogus report of module loading
"trouble".  This was my bad: an old init script was running
"modprobe -a".  Sigh...

-- 
Bob Tracy                                            rct@frus.com
-----------------------------------------------------------------
 "We might not be in hell, but we can see the gates from here."
 --Phoenix resident, Summer of 2000
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
