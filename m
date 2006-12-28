Return-Path: <linux-kernel-owner+w=401wt.eu-S932854AbWL1S1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932854AbWL1S1f (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 13:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933010AbWL1S1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 13:27:35 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:54920 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932854AbWL1S1e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 13:27:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=BuNNzN6vCbElLRSwMopKw9ElETR4qwODeelXGdPgTmLiuPi8rJoqL7OaVfAyYjSXPSukMimtC/65LcvB8VfGzSEVgvraVeqKkIy1sBprmPN1uZYs5UG/++/DDM/n5Dt8MAQvirrO7/wpE6QSAOAiDrNEMeJWQCAXBLt4aUl43MY=
Date: Thu, 28 Dec 2006 21:27:34 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@osdl.org
Cc: Thomas Hisch <t.hisch@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] fuse: fix typo
Message-ID: <20061228182734.GA4952@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hisch <t.hisch@gmail.com>

Signed-off-by: Thomas Hisch <t.hisch@gmail.com>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 Documentation/filesystems/fuse.txt |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/Documentation/filesystems/fuse.txt
+++ b/Documentation/filesystems/fuse.txt
@@ -94,8 +94,8 @@ Mount options
   filesystem is free to implement it's access policy or leave it to
   the underlying file access mechanism (e.g. in case of network
   filesystems).  This option enables permission checking, restricting
-  access based on file mode.  This is option is usually useful
-  together with the 'allow_other' mount option.
+  access based on file mode.  It is usually useful together with the
+  'allow_other' mount option.
 
 'allow_other'
 

