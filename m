Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262590AbTCRWtS>; Tue, 18 Mar 2003 17:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262591AbTCRWtS>; Tue, 18 Mar 2003 17:49:18 -0500
Received: from air-2.osdl.org ([65.172.181.6]:38871 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262590AbTCRWtR>;
	Tue, 18 Mar 2003 17:49:17 -0500
Subject: Re: [PATCH - for playing only] change type of dev_t
From: Andy Pfiffer <andyp@osdl.org>
To: Andries.Brouwer@cwi.nl
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <UTC200303182213.h2IMDse09784.aeb@smtp.cwi.nl>
References: <UTC200303182213.h2IMDse09784.aeb@smtp.cwi.nl>
Content-Type: text/plain
Organization: 
Message-Id: <1048028410.14097.9.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 18 Mar 2003 15:00:10 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-18 at 14:13, Andries.Brouwer@cwi.nl wrote:
> Below some random patch, not to be applied, so that
> people can play with a 32-bit dev_t.

I have dumped this set of patches into OSDL's patch system.  The builds
are still pending, but it should be possible in awhile to run tests with
this patch stack in the automated test environment at OSDL.

The patch stack:

1st patch:
http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1706

2nd patch:
http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1707

3rd patch:
http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1708

4th patch to flip the switch:
http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1709

Regards,
Andy


