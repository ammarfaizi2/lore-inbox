Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263436AbTJBRj3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 13:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263439AbTJBRj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 13:39:29 -0400
Received: from cpc3-hitc2-5-0-cust152.lutn.cable.ntl.com ([81.99.82.152]:43400
	"EHLO zog.reactivated.net") by vger.kernel.org with ESMTP
	id S263436AbTJBRj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 13:39:27 -0400
Message-ID: <3F7C62F2.4040401@reactivated.net>
Date: Thu, 02 Oct 2003 18:40:02 +0100
From: Daniel Drake <dan@reactivated.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030905 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] (2.6.0-test6) Trivial: linux-via mailinglist
Content-Type: multipart/mixed;
 boundary="------------000609010905050000040301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000609010905050000040301
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

In the MAINTAINERS file, there is an address for a mailing list under the "VIA 82Cxxx AUDIO DRIVER" heading.
I tried sending a mail there, and it got bounced back (user unknown).

I found an archive of this list on MARC, but as you can see it hasn't been active for about a year:
http://marc.theaimsgroup.com/?l=linux-via&r=1&w=2

Looks like that list is gone. Here's a patch to remove it from MAINTAINERS.

Daniel.

--------------000609010905050000040301
Content-Type: text/plain;
 name="trivial-via-list.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="trivial-via-list.patch"

--- linux-2.6.0-test6/MAINTAINERS	2003-09-28 11:34:13.000000000 +0100
+++ linux/MAINTAINERS	2003-10-02 18:33:23.970907088 +0100
@@ -2201,7 +2201,6 @@
 
 VIA 82Cxxx AUDIO DRIVER
 P:	Jeff Garzik
-L:	linux-via@gtf.org
 S:	Odd fixes
 
 VIA RHINE NETWORK DRIVER

--------------000609010905050000040301--

