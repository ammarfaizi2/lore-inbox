Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268135AbUIPP5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268135AbUIPP5P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 11:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268274AbUIPP4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 11:56:46 -0400
Received: from merkurneu.hrz.uni-giessen.de ([134.176.2.3]:53971 "EHLO
	merkurneu.hrz.uni-giessen.de") by vger.kernel.org with ESMTP
	id S268174AbUIPPwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 11:52:41 -0400
Date: Fri, 17 Sep 2004 01:52:03 +1000 (EST)
From: Sergei Haller <Sergei.Haller@math.uni-giessen.de>
X-X-Sender: gc1007@fb07-calculator.math.uni-giessen.de
To: Andrew Walrond <andrew@walrond.org>
Subject: Re: lost memory on a 4GB amd64
In-Reply-To: <200409161619.28742.andrew@walrond.org>
Message-Id: <Pine.LNX.4.58.0409170147320.26494@fb07-calculator.math.uni-giessen.de>
References: <Pine.LNX.4.58.0409161445110.1290@magvis2.maths.usyd.edu.au>
 <200409161528.19409.andrew@walrond.org>
 <Pine.LNX.4.58.0409170051200.26494@fb07-calculator.math.uni-giessen.de>
 <200409161619.28742.andrew@walrond.org>
Organization: University of Giessen * Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-HRZ-JLUG-MailScanner-Information: Passed JLUG virus check
X-HRZ-JLUG-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2004, Andrew Walrond (AW) wrote:

AW> On Thursday 16 Sep 2004 15:56, Sergei Haller wrote:
AW> > On Thu, 16 Sep 2004, Andrew Walrond (AW) wrote:
AW> >
AW> > AW>
AW> > AW> On further investigation, The settings I mentioned, 'Auto' and
AW> > 'Continuous' AW> only work when running a 64bit kernel. Are you running a
AW> > 32bit kernel?
AW> >
AW> > it's a 64bit one. the precise setting for the processor is
AW> > "AMD-Opteron/Athlon64". Should I try "Generic-x86-64"?
AW> 
AW> No - thats what I use. Do you have MTRR support enabled?

yes.

AW> I'll send you my .config file; Perhaps you could try that.

I just had a look at it. tomorrow morning I'll try out some of the 
options. If you like, I can send you my .config, so you can tell me which 
options are more likely to affect memory handling.

c ya
        Sergei
-- 
--------------------------------------------------------------------  -?)
         eMail:       Sergei.Haller@math.uni-giessen.de               /\\
-------------------------------------------------------------------- _\_V
Be careful of reading health books, you might die of a misprint.
                -- Mark Twain
