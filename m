Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262653AbTCTWCJ>; Thu, 20 Mar 2003 17:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262659AbTCTWCI>; Thu, 20 Mar 2003 17:02:08 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:47086 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262653AbTCTWBQ>;
	Thu, 20 Mar 2003 17:01:16 -0500
Subject: LTP version 20030306
To: ltp-list@lists.sourceforge.net, ltp-announce@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Cc: lge@us.ibm.com, lindajs@us.ibm.com
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
Message-ID: <OFA4093E14.AB316F7E-ON86256CEF.00784F88-86256CEF.0079F340@rchland.ibm.com>
From: "Doug Ramier" <v2cibdr@us.ibm.com>
Date: Thu, 20 Mar 2003 16:12:00 -0600
X-MIMETrack: Serialize by Router on d27ml101/27/M/IBM(Release 5.0.11  |July 24, 2002) at
 03/20/2003 04:12:02 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have found that in the past several months that the LTP version appears
to become "buggier" with each successive release.

>From the patches that are coming across this list there are an incredible
number of problems.

After overcoming problems with the compilation, we are getting between 50
and 130 failures on 64 and 32 bit versions which with 20030206 we had on
the order of a dozen.

I have a few questions:
1) Is everyone getting a "large" number of false failures?
2) Are the tests checked out before being released by SourceForge?
3) Are the tests only verified on Intel?  How about PowerPC and iSeries?
4) Is there a version released after the release that has the 205 patches
installed?

Thanks,
Doug Ramier
pSeries /  iSeries Linux Testing
507/253-2186
t/l 553-2186



