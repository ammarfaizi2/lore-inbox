Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262670AbVDMIF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262670AbVDMIF6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 04:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262504AbVDMIFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 04:05:42 -0400
Received: from baythorne.infradead.org ([81.187.226.107]:26765 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S262680AbVDMICS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 04:02:18 -0400
Subject: TESTING: new git commits mail
From: David Woodhouse <dwmw2@infradead.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 13 Apr 2005 09:02:17 +0100
Message-Id: <1113379337.12012.142.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've set up a script to replace the old one which mailed commits to the
bk-commits-head mailing list. It's fed from Linus' "kernel-test.git"
repository, which isn't necessarily going to end up going into the real
2.6.12 release -- but in the absence of other information or indeed any
tree which definitely _is_ leading to the next release, we might as well
see these commits.

I've stopped setting the Date: header of the mail to match the timestamp
of the commit. That's partly because the current version of git doesn't
actually _include_ the full timestamp information properly, but mostly
because some people were requesting that I do that for the old bkexport
script anyway.

-- 
dwmw2


