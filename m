Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268122AbUIPO6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268122AbUIPO6H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 10:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268130AbUIPO5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 10:57:32 -0400
Received: from merkurneu.hrz.uni-giessen.de ([134.176.2.3]:6347 "EHLO
	merkurneu.hrz.uni-giessen.de") by vger.kernel.org with ESMTP
	id S268122AbUIPO4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 10:56:39 -0400
Date: Fri, 17 Sep 2004 00:56:16 +1000 (EST)
From: Sergei Haller <Sergei.Haller@math.uni-giessen.de>
X-X-Sender: gc1007@fb07-calculator.math.uni-giessen.de
To: linux-kernel@vger.kernel.org
Cc: Andrew Walrond <andrew@walrond.org>
Subject: Re: lost memory on a 4GB amd64
In-Reply-To: <200409161528.19409.andrew@walrond.org>
Message-Id: <Pine.LNX.4.58.0409170051200.26494@fb07-calculator.math.uni-giessen.de>
References: <Pine.LNX.4.58.0409161445110.1290@magvis2.maths.usyd.edu.au>
 <200409161448.39033.andrew@walrond.org>
 <Pine.LNX.4.58.0409162358570.26494@fb07-calculator.math.uni-giessen.de>
 <200409161528.19409.andrew@walrond.org>
Organization: University of Giessen * Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-HRZ-JLUG-MailScanner-Information: Passed JLUG virus check
X-HRZ-JLUG-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2004, Andrew Walrond (AW) wrote:

AW> 
AW> On further investigation, The settings I mentioned, 'Auto' and 'Continuous' 
AW> only work when running a 64bit kernel. Are you running a 32bit kernel?

it's a 64bit one. the precise setting for the processor is 
"AMD-Opteron/Athlon64". Should I try "Generic-x86-64"?

BTW, 32bit processors are not offered at all.


        Sergei
-- 
--------------------------------------------------------------------  -?)
         eMail:       Sergei.Haller@math.uni-giessen.de               /\\
-------------------------------------------------------------------- _\_V
Be careful of reading health books, you might die of a misprint.
                -- Mark Twain
