Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291916AbSBNVBd>; Thu, 14 Feb 2002 16:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291890AbSBNU6a>; Thu, 14 Feb 2002 15:58:30 -0500
Received: from e24.nc.us.ibm.com ([32.97.136.230]:53992 "EHLO
	e24.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S291903AbSBNU6U>; Thu, 14 Feb 2002 15:58:20 -0500
Subject: [ANNOUNCE] Test Results (and requests) Mailing List
From: Paul Larson <plars@austin.ibm.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 14 Feb 2002 14:49:07 -0600
Message-Id: <1013719748.26463.107.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux Test Project (http://ltp.sourceforge.net) has a new mailing
list for the purpose of publishing and requesing test results.  We are
creating this list as a convenient means keeping a central, archived
place where anyone can publish the results of tests being run on Linux.
This list may also serve as a place for developers to request others to
test their patches, then reply to the list with results.

We encourage everyone in the Linux Community to start actively testing
Linux and publishing the results of those tests.

To subscribe to the list, either go through our website at
http://ltp.sourceforge.net, or go directly to the subscribe link at:
http://lists.sourceforge.net/mailman/listinfo/ltp-results


For clarity, and easy searching and browsing of test results, please try
to use the following format for your subject line:

If you are reporting test results:
Subject: (what is being tested) - (Test ran) - (Pass/fail [%])
For instance, if you are reporing the results of testing 2.4.18-rc1 with
ltp-20020207 and it passed at 100%, use  something like:
2.4.18-rc1 - ltp-20020207 - Pass 100%

If you are requesting a test, use the same format (with out the pass
fail at the end of course) and begine the subject line with [REQ].  For
instance:
[REQ] 2.5.5-pre1+mypatch - LTP-20020207 96hours
And of course include your patch, or a link to it.

The subject line should contain overview type information.  Any details,
results, etc. should be included in the body of the message.

