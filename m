Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130267AbQKBMt0>; Thu, 2 Nov 2000 07:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130889AbQKBMtH>; Thu, 2 Nov 2000 07:49:07 -0500
Received: from gherkin.sa.wlk.com ([192.158.254.49]:7684 "HELO
	gherkin.sa.wlk.com") by vger.kernel.org with SMTP
	id <S130267AbQKBMtB>; Thu, 2 Nov 2000 07:49:01 -0500
Message-Id: <m13rJnd-0005keC@gherkin.sa.wlk.com>
From: rct@gherkin.sa.wlk.com (Bob_Tracy)
Subject: Re: ESS device "1998"
To: linux-kernel@vger.kernel.org
Date: Thu, 2 Nov 2000 06:48:57 -0600 (CST)
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mo McKinlay wrote:
> 00:0d.0 Multimedia audio controller: ESS Technology: Unknown device 1998
> 00:0d.1 Communication controller: ESS Technology: Unknown device 1999
> 
> Any hints/clues/etc welcome.

Welcome to the "wonderful" world of the Maestro 3i.  You'll find
the following URL to be of interest...

http://www.zabbo.net/mailman/listinfo/maestro-users

Executive summary: a free driver is in its infancy, and you're
more than welcome to join the debugging effort.  If you *must*
have sound capability, go to http://www.opensound.com and get the
OSS driver: that will run you $15 for the base driver, and
another $15 for the ESS Maestro add-on.  It works well on my Dell
Latitude CPx.  You can try before you buy, and the 2.4.X kernel
support is pretty good: new driver versions lag the release of a
2.4.0-testX kernel by less than a week in most cases.

Good luck!

-- 
Bob Tracy                                            rct@frus.com
-----------------------------------------------------------------
 "We might not be in hell, but we can see the gates from here."
 --Phoenix resident, Summer of 2000
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
