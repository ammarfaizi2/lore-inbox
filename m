Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264203AbTFYIaU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 04:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264219AbTFYIaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 04:30:20 -0400
Received: from mail019.syd.optusnet.com.au ([210.49.20.160]:50860 "EHLO
	mail019.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264203AbTFYIaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 04:30:18 -0400
Date: Wed, 25 Jun 2003 18:43:09 +1000
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [trivial 2.5] kconfig language doc r.e. --help--
Message-ID: <20030625084309.GA9295@cancer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Stewart Smith <stewart@linux.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How does this read? hopefully it makes sense :)

--- linux-2.5.73/Documentation/kbuild/kconfig-language.txt	2003-06-15 17:47:18.000000000 +1000
+++ linux-2.5.73-stew1/Documentation/kbuild/kconfig-language.txt	2003-06-25 18:38:49.000000000 +1000
@@ -109,6 +109,8 @@
   This defines a help text. The end of the help text is determined by
   the indentation level, this means it ends at the first line which has
   a smaller indentation than the first line of the help text.
+  You may also use dashes around the word help to assist in the visual
+  separation of help from configuration. e.g. '--help--' or '---help---'.
+  These dashes have no effect on functionality, they are purely decorative.
 
 Menu dependencies


-- 
Stewart Smith
Vice President, Linux Australia
http://www.linux.org.au (personal: http://www.flamingspork.com)
