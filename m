Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbVHRJQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbVHRJQL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 05:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbVHRJQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 05:16:11 -0400
Received: from [195.209.228.254] ([195.209.228.254]:50333 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S932143AbVHRJQK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 05:16:10 -0400
Subject: [TRIVIAL 2.6.13-rc6] fixe sparse tarball URL
From: "Artem B. Bityuckiy" <dedekind@infradead.org>
Reply-To: dedekind@infradead.org
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-caXM4rlo9X7mX4sxP054"
Organization: MTD
Date: Thu, 18 Aug 2005 13:16:08 +0400
Message-Id: <1124356569.2232.3.camel@sauron.oktetlabs.ru>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-caXM4rlo9X7mX4sxP054
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Fix URL of the sparse tarball.

Signed-off-by: Artem B. Bityuckiy <dedekind@infradead.org>

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.

--=-caXM4rlo9X7mX4sxP054
Content-Disposition: attachment; filename=sparse-doc-url-fix.diff
Content-Type: text/x-patch; name=sparse-doc-url-fix.diff; charset=KOI8-R
Content-Transfer-Encoding: 7bit

diff -auNrp linux-2.6.13-rc6/Documentation/sparse.txt linux-2.6.13-rc6-fixed/Documentation/sparse.txt
--- linux-2.6.13-rc6/Documentation/sparse.txt	2005-06-17 23:48:29.000000000 +0400
+++ linux-2.6.13-rc6-fixed/Documentation/sparse.txt	2005-08-18 13:10:31.768153081 +0400
@@ -57,7 +57,7 @@ With BK, you can just get it from
 
 and DaveJ has tar-balls at
 
-	http://www.codemonkey.org.uk/projects/bitkeeper/sparse/
+	http://www.codemonkey.org.uk/projects/git-snapshots/sparse/
 
 
 Once you have it, just do

--=-caXM4rlo9X7mX4sxP054--

