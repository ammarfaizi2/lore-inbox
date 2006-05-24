Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932746AbWEXRt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932746AbWEXRt7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 13:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932748AbWEXRt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 13:49:59 -0400
Received: from web50106.mail.yahoo.com ([206.190.38.34]:64380 "HELO
	web50106.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932746AbWEXRt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 13:49:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=EIEcdxkNvhIYlHyD8zRTwwlpI+I3oIvXGjpfuRm8tx/HsZSbn/POwBhjcuBGIerrUuX5niW9oOE0Zg7VUQzgBNtr38emzPRGgO2p84Tq4TRzlggOwNvRCG59Q+34JkhVcH4L25lemS4zQ/AMVzPYQoKzeL2jWny168/S3Ym2/EA=  ;
Message-ID: <20060524174957.25600.qmail@web50106.mail.yahoo.com>
Date: Wed, 24 May 2006 10:49:57 -0700 (PDT)
From: Doug Thompson <norsk5@yahoo.com>
Subject: [PATCH 6/6]  EDAC maintainers update
To: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Removed Dave Peterson as per his request as co-maintainer of EDAC
Thanks for the work Dave.

Signed-of-by: Doug Thompson <norsk5@xmission.com>


Index: linux-2.6.17-rc4/MAINTAINERS
===================================================================
--- linux-2.6.17-rc4.orig/MAINTAINERS	2006-05-23 10:40:04.000000000 -0600
+++ linux-2.6.17-rc4/MAINTAINERS	2006-05-24 11:02:07.000000000 -0600
@@ -892,23 +892,21 @@
 
 EDAC-CORE
 P:	Doug Thompson
-M:	norsk5@xmission.com, dthompson@linuxnetworx.com
-P:	Dave Peterson
-M:	dsp@llnl.gov, dave_peterson@pobox.com
+M:	norsk5@xmission.com
 L:	bluesmoke-devel@lists.sourceforge.net
 W:	bluesmoke.sourceforge.net
-S:	Maintained
+S:	Supported
 
 EDAC-E752X
-P:	Dave Peterson
-M:	dsp@llnl.gov, dave_peterson@pobox.com
+P:	Mark Gross
+M:	mark.gross@intel.com
 L:	bluesmoke-devel@lists.sourceforge.net
 W:	bluesmoke.sourceforge.net
 S:	Maintained
 
 EDAC-E7XXX
-P:	Dave Peterson
-M:	dsp@llnl.gov, dave_peterson@pobox.com
+P:	Doug Thompson
+M:	norsk5@xmission.com
 L:	bluesmoke-devel@lists.sourceforge.net
 W:	bluesmoke.sourceforge.net
 S:	Maintained



"If you think Education is expensive, just try Ignorance"

"Don't tell people HOW to do things, tell them WHAT you
want and they will surprise you with their ingenuity."
                   Gen George Patton

