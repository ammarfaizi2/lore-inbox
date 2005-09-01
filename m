Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030375AbVIAUaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030375AbVIAUaM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 16:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030377AbVIAUaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 16:30:11 -0400
Received: from host-84-9-201-83.bulldogdsl.com ([84.9.201.83]:11401 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S1030375AbVIAUaK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 16:30:10 -0400
Date: Thu, 1 Sep 2005 21:30:06 +0100
From: Ben Dooks <ben-lkinux@fluff.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/sparse snapshot URL
Message-ID: <20050901203006.GA17740@home.fluff.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The URL for Documentation/sparse is wrong now that it is
in git.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sparse-git-place.patch"

diff -urN -X ../dontdiff linux-2.6.13/Documentation/sparse.txt linux-2.6.13-bjd1/Documentation/sparse.txt
--- linux-2.6.13/Documentation/sparse.txt	2005-06-17 20:48:29.000000000 +0100
+++ linux-2.6.13-bjd1/Documentation/sparse.txt	2005-09-01 21:28:27.000000000 +0100
@@ -57,7 +57,7 @@
 
 and DaveJ has tar-balls at
 
-	http://www.codemonkey.org.uk/projects/bitkeeper/sparse/
+	http://www.codemonkey.org.uk/projects/git-snapshots/sparse/
 
 
 Once you have it, just do

--RnlQjJ0d97Da+TV1--
