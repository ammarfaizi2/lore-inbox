Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268553AbUIXI6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268553AbUIXI6V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 04:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268582AbUIXI6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 04:58:21 -0400
Received: from merkurneu.hrz.uni-giessen.de ([134.176.2.3]:33438 "EHLO
	merkurneu.hrz.uni-giessen.de") by vger.kernel.org with ESMTP
	id S268553AbUIXI6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 04:58:20 -0400
Date: Fri, 24 Sep 2004 18:57:57 +1000 (EST)
From: Sergei Haller <Sergei.Haller@math.uni-giessen.de>
X-X-Sender: gc1007@fb07-calculator.math.uni-giessen.de
To: Andrew Walrond <andrew@walrond.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lost memory on a 4GB amd64
In-Reply-To: <200409240931.42356.andrew@walrond.org>
Message-Id: <Pine.LNX.4.58.0409241856120.16011@fb07-calculator.math.uni-giessen.de>
References: <Pine.LNX.4.58.0409161445110.1290@magvis2.maths.usyd.edu.au>
 <200409240915.34471.andrew@walrond.org>
 <Pine.LNX.4.58.0409241819370.15313@fb07-calculator.math.uni-giessen.de>
 <200409240931.42356.andrew@walrond.org>
Organization: University of Giessen * Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-HRZ-JLUG-MailScanner-Information: Passed JLUG virus check
X-HRZ-JLUG-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sep 2004, Andrew Walrond (AW) wrote:

AW> On Friday 24 Sep 2004 09:23, Sergei Haller wrote:
AW> > It's the same for me if I use the non-SMP version of the kernel.
AW> > but the SMP one seems to be panicking for some reason.
AW> >
AW> 
AW> Just a thought; How are the memory modules arranged on the board?
AW> I have 2 x 1Gb modules in each cpu-specific bank, rather than all four in 
AW> cpu1's bank. How are yours arranged?

my board has only four banks, each of them has a 1GB module sitting.
(page 26 of ftp://ftp.tyan.com/manuals/m_s2875_102.pdf)


        Sergei
-- 
--------------------------------------------------------------------  -?)
         eMail:       Sergei.Haller@math.uni-giessen.de               /\\
-------------------------------------------------------------------- _\_V
Be careful of reading health books, you might die of a misprint.
                -- Mark Twain
