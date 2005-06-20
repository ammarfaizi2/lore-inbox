Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbVFTWqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbVFTWqV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 18:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbVFTWof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 18:44:35 -0400
Received: from coderock.org ([193.77.147.115]:31131 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262073AbVFTWFw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:05:52 -0400
Message-Id: <20050620215722.845793000@nd47.coderock.org>
Date: Mon, 20 Jun 2005 23:57:22 +0200
From: domen@coderock.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
       domen@coderock.org
Subject: [patch 4/4] DCO: use IANA-reserved second level domain name
Content-Disposition: inline; filename=dco-Documentation_SubmittingPatches
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Dobriyan <adobriyan@gmail.com>


Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Domen Puncer <domen@coderock.org>

---
 SubmittingPatches |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: quilt/Documentation/SubmittingPatches
===================================================================
--- quilt.orig/Documentation/SubmittingPatches
+++ quilt/Documentation/SubmittingPatches
@@ -299,7 +299,7 @@ can certify the below:
 
 then you just add a line saying
 
-	Signed-off-by: Random J Developer <random@developer.org>
+	Signed-off-by: Random J Developer <random@developer.example.org>
 
 Some people also put extra tags at the end.  They'll just be ignored for
 now, but you can do this to mark internal company procedures or just

--
