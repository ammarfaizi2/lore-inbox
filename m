Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264039AbTDWNmi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 09:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264040AbTDWNmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 09:42:38 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:10209 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S264039AbTDWNmg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 09:42:36 -0400
Date: Wed, 23 Apr 2003 15:52:50 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Bad url in ioctl numbers [DVD decoder driver]
Message-ID: <20030423135250.GA332@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This warns about bad url. I do not know what better to do with this.

								Pavel

%patch
Index: linux/Documentation/ioctl-number.txt
===================================================================
--- linux.orig/Documentation/ioctl-number.txt	2003-04-22 00:04:32.000000000 +0200
+++ linux/Documentation/ioctl-number.txt	2003-03-30 20:01:55.000000000 +0200
@@ -174,7 +174,7 @@
 0xA0	all	linux/sdp/sdp.h		Industrial Device Project
 					<mailto:kenji@bitgate.com>
 0xA2    00-0F   DVD decoder driver      in development:
-                                        <http://linuxtv.org/dvd/api/>
+					URL no longer works: http://linuxtv.org/dvd/api/
 0xA3	00-1F	Philips SAA7146 dirver	in development:
 					<mailto:Andreas.Beckmann@hamburg.sc.philips.com>
 0xA3	80-8F	Port ACL		in development:


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
