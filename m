Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131369AbRAOEKW>; Sun, 14 Jan 2001 23:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131745AbRAOEKN>; Sun, 14 Jan 2001 23:10:13 -0500
Received: from 209.102.21.2 ([209.102.21.2]:39428 "EHLO dragnet.seagull.net")
	by vger.kernel.org with ESMTP id <S131369AbRAOEKE>;
	Sun, 14 Jan 2001 23:10:04 -0500
Message-ID: <3A6247AF.936B1AE1@goingware.com>
Date: Mon, 15 Jan 2001 00:43:27 +0000
From: "Michael D. Crawford" <crawford@goingware.com>
Organization: GoingWare Inc. - Expert Software Development and Consulting
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Article: Using test suites to test the new kernel
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've written a brief article on the topic of using test suites to test new linux
kernels.  

It is my hope that anyone who wants to play with the new kernels will try out
some of these suites, not just people doing a formal QA process, so that more
coverage of configurations can be achieved.

Using Test Suites to Validate the Linux Kernel
http://linuxquality.sunsite.dk/articles/testsuites/

I cover the use of suites that test the correct functioning of applications (for
example, language compliance tests for Python and Kaffe's Java implementation)
as well as test suites aimed directly at testing Linux itself.

Links to five different packages with test suites are given.  I'd appreciate
hearing of any more that you know about.

I also appreciate your comments on how I can improve the article.  This is a
first draft.

Regards,

Mike Crawford
-- 
Michael D. Crawford
GoingWare Inc. - Expert Software Development and Consulting
http://www.goingware.com/
crawford@goingware.com

   Tilting at Windmills for a Better Tomorrow.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
