Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbTIOJNO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 05:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbTIOJNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 05:13:14 -0400
Received: from imo-d02.mx.aol.com ([205.188.157.34]:5537 "EHLO
	imo-d02.mx.aol.com") by vger.kernel.org with ESMTP id S261596AbTIOJNN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 05:13:13 -0400
Date: Mon, 15 Sep 2003 05:12:59 -0400
From: jpo234@netscape.net
To: remi.colinet@wanadoo.fr
Cc: linux-kernel@vger.kernel.org
Subject: Re: 1:1 M:N threading
MIME-Version: 1.0
Message-ID: <1717A06D.56EB198A.00065BAA@netscape.net>
X-Mailer: Atlas Mailer 2.0
X-AOL-IP: 62.96.207.14
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

remi.colinet@wanadoo.fr wrote:
 > For 2.6, the default is NGPT (see 
 > http://www-124.ibm.com/developerworks/oss/pthreads/) which is 1:1.

NGPT is frozen and in maintenance mode (which is a different
wording for "dead"). See
http://www-124.ibm.com/pthreads/docs/announcement
The new default Linux pthread implementation is RedHats NPTL. See
http://people.redhat.com/~drepper/nptl-design.pdf
for details, which btw. is 1:1 as well.

Regards
  jpo

__________________________________________________________________
McAfee VirusScan Online from the Netscape Network.
Comprehensive protection for your entire computer. Get your free trial today!
http://channels.netscape.com/ns/computing/mcafee/index.jsp?promo=393397

Get AOL Instant Messenger 5.1 free of charge.  Download Now!
http://aim.aol.com/aimnew/Aim/register.adp?promo=380455
