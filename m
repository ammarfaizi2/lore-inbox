Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264962AbUD2Uja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264962AbUD2Uja (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 16:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264984AbUD2Uja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 16:39:30 -0400
Received: from smtp.nildram.co.uk ([195.112.4.54]:11790 "EHLO
	smtp.nildram.co.uk") by vger.kernel.org with ESMTP id S264962AbUD2Uba
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 16:31:30 -0400
Message-ID: <40916653.4050904@phekda.gotadsl.co.uk>
Date: Thu, 29 Apr 2004 21:32:19 +0100
From: Richard Dawe <rich@phekda.gotadsl.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031031
X-Accept-Language: en, de, fr
MIME-Version: 1.0
To: torvalds@osdl.org
Cc: Richard Dawe <rich@phekda.gotadsl.co.uk>, linux-kernel@vger.kernel.org
Subject: Patch for 2.6.x: Add procps URL to Doc/Changes
Content-Type: multipart/mixed;
 boundary="------------060001000802060903050206"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060001000802060903050206
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

Attached is a patch to add a URL for the procps home page to
Documentation/Changes.

It was made against Linux 2.6.4-rc2, but it applies cleanly to Linux
2.6.6-rc2.

Bye, Rich =]

-- 
Richard Dawe [ http://homepages.nildram.co.uk/~phekda/richdawe/ ]

"You can't evaluate a man by logic alone."
      -- McCoy, "I, Mudd", Star Trek




--------------060001000802060903050206
Content-Type: text/plain;
 name="linux-2.6.4-rc2-changes-procps.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.4-rc2-changes-procps.diff"

--- linux-2.6.4-rc2/Documentation/Changes.orig	2004-03-08 21:08:37.000000000 +0000
+++ linux-2.6.4-rc2/Documentation/Changes	2004-03-08 21:10:39.000000000 +0000
@@ -349,9 +349,13 @@ Pcmcia-cs
 o  <ftp://pcmcia-cs.sourceforge.net/pub/pcmcia-cs/pcmcia-cs-3.1.21.tar.gz>
 
 Quota-tools
-----------
+-----------
 o  <http://sourceforge.net/projects/linuxquota/>
 
+Procps
+------
+o  <http://procps.sourceforge.net/>
+
 Jade
 ----
 o  <ftp://ftp.jclark.com/pub/jade/jade-1.2.1.tar.gz>




--------------060001000802060903050206--

