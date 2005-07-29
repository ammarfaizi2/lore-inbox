Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262773AbVG2TSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262773AbVG2TSR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 15:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262752AbVG2TPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 15:15:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:38318 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262743AbVG2TPU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:15:20 -0400
Date: Fri, 29 Jul 2005 12:13:09 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, dwalker@mvista.com
Subject: [patch 01/29] stable_api_nonsense.txt fixes
Message-ID: <20050729191308.GB5095@kroah.com>
References: <20050729184950.014589000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Walker <dwalker@mvista.com>

Signed-off-by: Daniel Walker <dwalker@mvista.com> 
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 Documentation/stable_api_nonsense.txt |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- gregkh-2.6.orig/Documentation/stable_api_nonsense.txt	2005-07-29 11:31:38.000000000 -0700
+++ gregkh-2.6/Documentation/stable_api_nonsense.txt	2005-07-29 11:33:48.000000000 -0700
@@ -132,7 +132,7 @@
 their work on their own time, asking programmers to do extra work for no
 gain, for free, is not a possibility.
 
-Security issues are also a very important for Linux.  When a
+Security issues are also very important for Linux.  When a
 security issue is found, it is fixed in a very short amount of time.  A
 number of times this has caused internal kernel interfaces to be
 reworked to prevent the security problem from occurring.  When this

--
